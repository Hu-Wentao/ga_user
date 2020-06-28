// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/1/18
// Time  : 12:41
import 'package:flutter/foundation.dart';
import 'package:get_arch_core/domain/common_interface.dart';

import '../value_objects.dart';

///
/// 用户实体类
class User extends IEntity {
  // 唯一标识一个用户
  final String id;

  // 用户的昵称
  final String nickname;

  // 用户邮箱
  final EmailAddress email;

  // 用户注册时间 <服务器生成>
  final int regTime;

  // 登陆口令 <服务器生成>
  final String token;

  final Password password;

  // 手机号
  final PhoneNumber phone;

  // 头像的url
  final String avatar;

  // 性别 0男 1女,这里没有用bool,因为...性别可能会有很多种
  final Sex sex;

  // 全参构造
  User._({
    this.id,
    this.nickname,
    this.email,
    this.regTime,
    this.token,
    this.password,
    this.phone,
    this.avatar,
    this.sex,
  });

  ///
  /// 从服务端获取的,用户登陆成功的返回值
  User.fromResult({
    @required this.id,
    @required this.nickname,
    @required this.email,
    @required this.regTime,
    @required this.phone,
    @required this.avatar,
    @required this.sex,
    @required this.token,
  }) : password = null; // 本地不存储密码,只存储token

  ///
  /// 通过邮箱登陆/注册的构造方法
  User.authWithEmail(
    EmailAddress email,
    Password password,
  ) : this._(email: email, password: password);

  ///
  /// 通过手机号..
  User.authWithPhone(
    PhoneNumber phone,
    Password password,
  ) : this._(phone: phone, password: password);

  @override
  List<Object> get props =>
      [id, nickname, email, regTime, phone, avatar, sex, token];
}

enum Sex{
  male,
  female,
}