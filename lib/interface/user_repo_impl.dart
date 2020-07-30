// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 13:15
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/failures.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:get_env_info/interface/dto/dto.dart';
import 'package:get_env_info/interface/i_env_info_source.dart';
import 'package:get_arch_quick_start/domain/error/failures.dart';
import 'package:get_arch_quick_start/quick_start_part.dart';
import 'package:get_arch_core/get_arch_core.dart';

import 'dto/auth_dto.dart';
import 'dto/user_dto.dart';
import 'i_user_api.dart';
import 'i_user_local.dart';

//@LazySingleton(as: IUserRepo) // 手动注册
class UserRepoImpl extends IUserRepo {
  // 网络源
  final IUserAPI _api;

  // 本地源
  final IUserLocal _local;

  // 环境数据
  final IEnvInfoSource _envSource;

  // 当前用户 fixme LiveModel更适合在 数据源(_local)中定义
  ControlledLiveModel<User> _curLiveUser;

  UserRepoImpl(this._local, this._api, this._envSource) {
    _curLiveUser = ControlledLiveModel<User>(getData: () => query(null));
  }

  /// 缓存到本地, [user] 与 [dto]只需要填写一个
  _cacheToLocal({User user, UserDto userDto}) {
    // 如果直接传入DTO, 则不再检测User
    if (userDto != null) {
      _curLiveUser.postRight(userDto.toDomain());
    } else {
      // 此时检测User
      if (user == null) {
        _curLiveUser.postLeft(NotLoginFailure());
      } else {
        userDto = UserDto.fromDomain(user);
        _curLiveUser.postRight(user);
      }
    }
    _local.setCurUserDto(userDto);
  }

  @override
  Future<Either<Failure, Unit>> loginWithEmail(User param) async =>
      _processLoginOrRegister(true, param);

  @override
  Future<Either<Failure, Unit>> registerWithEmail(User param) async =>
      _processLoginOrRegister(false, param);

  // 内部处理
  Future<Either<Failure, Unit>> _processLoginOrRegister(
      bool isLogin, User p) async {
    try {
      final env = await _envSource.getEnvInfo();
      final authDto =
          AuthDto.fromDomain(p.email, p.password, EnvInfoDto.fromDomain(env));
      // 从网络获取数据
      final jsData = await (isLogin
          ? await _api.login(authDto)
          : await _api.register(authDto));

      final data = jsData['data'];
      if (data == null) throw jsData;
      // 缓存到本地
      _cacheToLocal(userDto: UserDto.fromJson(data));
      return Right(null);
    } catch (e, s) {
      return Left(UnknownFailure(
          'UserRepoImpl._processLoginOrRegister\napi[${_api.runtimeType}]\ne[$e]',
          s));
    }
  }

  @override
  Future<Either<Failure, User>> query(String uId) async {
    try {
      if (uId != null) {
        // 通过id查询用户
        final jsData = await _api.queryById(uId);
        final data = jsData['data'];
        if (data == null) return left(UserNotFoundFailure());
        final u = UserDto.fromJson(data).toDomain();
        return right(u);
      } else {
        final u = _local.getCurUserDto().toDomain();
        if (u == null) return left(NotLoginFailure());
        return right(u);
      }
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.curUser:$e', s));
    }
  }

  LiveModel<User> liveUser() => _curLiveUser;

  @override
  Future<Either<Failure, Unit>> update(User user) async {
    try {
      // 网络请求
      final dto = UserDto.fromDomain(user);
      final js = await _api.updateInfo(dto);
      final nDto = UserDto.fromJson(js);
      // 刷新本地缓存
      _cacheToLocal(userDto: nDto);
      return right(null);
    } on Failure catch (f) {
      return left(f);
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.update:\n$e\n', s));
    }
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(String path) async {
    try {
      // 网络上传 注意 这里的path, 是包含了文件名称的文件路径
      final rspData = await _api.uploadAvatar(path);
      print('UserRepoImpl.uploadAvatar ##debug :$rspData');
      final imgId = rspData['data']['id'];
      // 本地缓存
      final img = await File(path).readAsBytes();
      _local.setAvatarBytes(imgId, img);
      // - 刷新 本地User的数据
      final nUserDto = _local.getCurUserDto().copyWith(id: imgId);
      _cacheToLocal(userDto: nUserDto);
      return right(imgId);
    } on Failure catch (f) {
      return left(f);
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.uploadAvatar:\n$e\n', s));
    }
  }

  @override
  Future<Either<Failure, Uint8List>> getAvatar(String imgId) async {
    try {
      // 本地读取 todo 为本地读写建立一个时间失效策略
      final imgBytes =
          _local.getAvatarBytes(imgId) ?? await _api.queryImg(imgId);
      return right(imgBytes);
    } on Failure catch (f) {
      return left(f);
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.getAvatar:\n$e\n', s));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      // 缓存置空
      _cacheToLocal();
      return right(null);
    } on Failure catch (f) {
      return left(f);
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.logout:\n$e\n', s));
    }
  }
}
