// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 13:13
import 'package:dartz/dartz.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:get_arch_core/domain/error/failures.dart';

///
/// 用户相关操作的repo
abstract class IUserRepo {
  /// 用户注册
  Future<Either<Failure, Unit>> createWithEmail(User param);

  /// 登出
//  Future<Either<Failure, Unit>> delete(User param);

  /// 更新用户资料
  Future<Either<Failure, Unit>> update(User param);

  @Deprecated('请使用 query()')
  Future<Either<Failure, String>> queryUid();

  /// 从数据源获取当前用户
  /// 状态不仅存储在前端Model中, 也存在于本地存储
  Future<Either<Failure, User>> query();

  /// 用户登陆/同步用户信息
  Future<Either<Failure, Unit>> queryWithEmail(User param);

//  // QQ登陆
//  Future<Either<Failure, Unit>> queryWithQQ();
//  // WeChat登陆
//  Future<Either<Failure, Unit>> queryWithWeChat();
}
