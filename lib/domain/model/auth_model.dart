// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/27
// Time  : 12:32
///
class AuthM {
  String emailAddress;

  String password;

  String rePwd;

  // view中,密码是否隐藏
  bool isPwdObscure = true;

  // pwd和rePwd是否匹配
  bool get isPwdEqual => password == rePwd;

  // view当前状态(登陆还是注册
  bool isLogin = true;

  // view 是否开始验证填入的值并展示出来
  bool isAutoValidate = false;
}
