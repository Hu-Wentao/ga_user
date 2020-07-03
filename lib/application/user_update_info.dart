// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/27
// Time  : 14:31

import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/ga_user.dart';
import 'package:get_arch_core/application/i_usecase.dart';
import 'package:get_arch_core/domain/error/failures.dart';
import 'package:get_arch_core/get_arch_part.dart';
import 'package:injectable/injectable.dart';

///
/// 用户修改个人信息
///
@lazySingleton
class UserUpdateInfo extends UseCase<Unit, User> {
  final IUserRepo repo;

  UserUpdateInfo(this.repo);

  @override
  Future<Either<Failure, Unit>> call(User params) async =>
      await repo.update(params);
}
