// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/4
// Time  : 19:34
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_arch_quick_start/quick_start_part.dart';

///
/// 参数为null表示获取当前已登陆用户
//@lazySingleton v
class GetUser extends UseCase<User, String> {
  final IUserRepo repo;

  GetUser(this.repo);
  @override
  Future<Either<Failure, User>> call(String uId) async => await repo.query(uId);
}