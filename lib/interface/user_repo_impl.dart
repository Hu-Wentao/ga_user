// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 13:15
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/failures.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:gat_env_info/interface/dto/dto.dart';
import 'package:gat_env_info/interface/i_env_info_source.dart';
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
  final IUserAPI api;

  // 本地源
  final IUserLocal local;

  // 环境数据
  final IEnvInfoSource envSource;

  UserRepoImpl(this.local, this.api, this.envSource);

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
      final env = await envSource.getEnvInfo();
      final authDto =
          AuthDto.fromDomain(p.email, p.password, EnvInfoDto.fromDomain(env));
      // 从网络获取数据
      final jsData = await (isLogin
          ? await api.login(authDto)
          : await api.register(authDto));

      final data = jsData['data'];
      if (data == null) throw jsData;
      // 缓存到本地
      local.setCurUserDto(UserDto.fromJson(data));
      return Right(null);
    } catch (e, s) {
      return Left(UnknownFailure(
          'UserRepoImpl._processLoginOrRegister\napi[${api.runtimeType}]\ne[$e]',
          s));
    }
  }

  @override
  Future<Either<Failure, User>> query(String uId) async {
    try {
      if (uId != null) {
        // 通过id查询用户
        final jsData = await api.queryById(uId);
        final data = jsData['data'];
        if (data == null) return left(UserNotFoundFailure());
        final u = UserDto.fromJson(data).toDomain();
        return right(u);
      } else {
        final u = local.getCurUserDto().toDomain();
        if (u == null) return left(NotLoginFailure());
        return right(u);
      }
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.curUser:$e', s));
    }
  }

  @override
  Future<Either<Failure, Unit>> update(User user) async {
    try {
      // 网络请求
      final dto = UserDto.fromDomain(user);
      await api.updateInfo(dto);
      // todo 需要接收api的返回值
      // 刷新本地缓存
      await local.setCurUserDto(dto);
      return right(null);
    } on Failure catch (f) {
      return left(f);
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.update:\n$e\n', s));
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadAvatar(String path) async {
    try {
      // 网络上传 注意 这里的path, 是包含了文件名称的文件路径
      final rspData = await api.uploadAvatar(path);
      print('UserRepoImpl.uploadAvatar ##debug :$rspData');
      final imgId = rspData['data']['id'];
      // 本地缓存
      final img = await File(path).readAsBytes();
      local.setAvatarBytes(imgId, img);
      // - 刷新 本地User的数据
      final nUserDto = local.getCurUserDto().copyWith(id: imgId);
      local.setCurUserDto(nUserDto);
      return right(null);
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
      final imgBytes = local.getAvatarBytes(imgId) ?? await api.queryImg(imgId);
      return right(imgBytes);
    } on Failure catch (f) {
      return left(f);
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.getAvatar:\n$e\n', s));
    }
  }
}
