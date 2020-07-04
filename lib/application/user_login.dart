// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/26
// Time  : 23:26

import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_arch_quick_start/quick_start_part.dart';

///
/// 用户登陆
//@lazySingleton
class UserLogin extends UseCase<Unit, User> {
  final IUserRepo userRepo;
  UserLogin(this.userRepo);
  @override
  Future<Either<Failure, Unit>> call(User p) async =>
      await userRepo.queryWithEmail(p);
}
