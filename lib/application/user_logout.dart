// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/15
// Time  : 11:32

import 'package:ga_user/ga_user.dart';
import 'package:get_arch_quick_start/quick_start.dart';

class UserLogout extends UseCase<Unit, Unit> {
  final IUserRepo repo;

  UserLogout(this.repo);
  @override
  Future<Either<Failure, Unit>> call(Unit params) => repo.logout();
}
