// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 13:15
import 'package:dartz/dartz.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:gat_env_info/domain/model.dart';
import 'package:gat_env_info/interface/dto/dto.dart';
import 'package:gat_env_info/interface/i_env_info_source.dart';
import 'package:get_arch_core/domain/error/failures.dart';
import 'package:get_arch_core/get_arch_core.dart';

import 'dto/auth_dto.dart';
import 'dto/user_dto.dart';
import 'i_user_api.dart';
import 'i_user_local.dart';

//@LazySingleton(as: IUserRepo) // 手动注册
class UserRepoImpl extends IUserRepo {
  EnvInfo env;
  // 网络源
  final IUserAPI api;

  // 本地源
  final IUserLocal userSource;

  // 环境数据
  final IEnvInfoSource envSource;

  UserRepoImpl(this.userSource, this.api, this.envSource);

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
      env ??= await envSource.getEnvInfo();
      final authDto =
          AuthDto.fromDomain(p.email, p.password, EnvInfoDto.fromDomain(env));
      final jsonData =
          isLogin ? await api.login(authDto) : await api.register(authDto);
      userSource.setCurUserDto(UserDto.fromJson(jsonData));
      return Right(null);
    } catch (e, s) {
      return Left(UnknownFailure(
          'UserRepoImpl._processLoginOrRegister\napi[$api}]\ne[$e]', s));
    }
  }

  @override
  Future<Either<Failure, User>> query() async {
    try {
      final u = userSource.getCurUserDto().toDomain();
      if (u == null) return left(NotLoginFailure());
      return right(u);
    } catch (e, s) {
      return left(UnknownFailure('UserRepoImpl.curUser:$e', s));
    }
  }

  @override
  Future<Either<Failure, User>> update(User user) async {
    try {
      // todo
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
