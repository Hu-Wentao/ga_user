// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 13:15
import 'package:dartz/dartz.dart';
import 'package:ga_user/domain/entities/user.dart';
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
  Future<Either<Failure, Unit>> queryWithEmail(User param) async =>
      _processLoginOrRegister(true, param);

  @override
  Future<Either<Failure, Unit>> createWithEmail(User param) async =>
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
      // 缓存到本地
      local.setCurUserDto(UserDto.fromJson(jsData));
      return Right(null);
    } catch (e, s) {
      return Left(UnknownFailure(
          'UserRepoImpl._processLoginOrRegister\napi[${api.runtimeType}]\ne[$e]',
          s));
    }
  }

  @override
  Future<Either<Failure, User>> query() async {
    try {
      final u = local.getCurUserDto().toDomain();
      if (u == null) return left(NotLoginFailure());
      return right(u);
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
  Future<Either<Failure, String>> queryUid() {
    throw UnimplementedError();
  }
}
