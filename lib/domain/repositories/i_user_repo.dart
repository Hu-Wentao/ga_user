// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 13:13

import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_arch_quick_start/quick_start_part.dart';

///
/// 用户相关操作的repo
abstract class IUserRepo {
  /// 用户注册
  Future<Either<Failure, Unit>> registerWithEmail(User param);

  /// 登出
//  Future<Either<Failure, Unit>> delete(User param);

  /// 更新用户资料
  Future<Either<Failure, Unit>> update(User param);

  /// 当[uId] 为null时, 从数据源获取当前用户
  /// 状态不仅存储在前端Model中, 也存在于本地存储
  Future<Either<Failure, User>> query(String uId);

  /// 用户登陆/同步用户信息
  Future<Either<Failure, Unit>> loginWithEmail(User param);

  Future<Either<Failure, Unit>> uploadAvatar(String filePath);

  /// UseCase应当保证[imgId]不为空
  Future<Either<Failure, Uint8List>> getAvatar(String imgId);

//  // QQ登陆
//  Future<Either<Failure, Unit>> queryWithQQ();
//  // WeChat登陆
//  Future<Either<Failure, Unit>> queryWithWeChat();
}
