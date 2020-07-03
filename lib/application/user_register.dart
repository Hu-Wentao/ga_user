// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/27
// Time  : 14:31

import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_arch_core/get_arch_part.dart';

/// 用户注册
@lazySingleton
class UserRegister extends UseCase<Unit, User> {
  final IUserRepo userRepo;

  UserRegister(this.userRepo);

  @override
  Future<Either<Failure, Unit>> call(User p) async =>
      await userRepo.createWithEmail(p);
}
