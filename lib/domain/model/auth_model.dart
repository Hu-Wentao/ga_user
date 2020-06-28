// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/27
// Time  : 12:32
import 'package:ga_user/domain/value_objects.dart';

/// 由于ViewModel中
class AuthM {
  EmailAddress emailAddress;

  Password password;

  Password rePassword;

  // view中,密码是否隐藏
  bool isPwdObscure = true;

  // pwd和rePwd是否匹配
  bool get isPwdEqual => password == rePassword;

  // view当前状态(登陆还是注册
  bool isLogin = true;

  // view 是否开始验证填入的值并展示出来
  bool isAutoValidate = false;
}
