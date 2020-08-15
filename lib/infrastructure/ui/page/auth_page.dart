// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/1
// Time  : 9:35
import 'package:flutter/material.dart';
import 'package:ga_user/interface/auth_vm.dart';
import 'package:ga_user/profile/user_package.dart';
import 'package:get_state/get_state.dart';

import '../auth_view.dart';

///
/// View级别注册,
/// get_state新版本不再推荐使用手动的Page级注册ViewModel
class AuthPage extends View<AuthVm> {
  // [isRoot]设为true, 在dispose时将会自动销毁[AuthVm]
  AuthPage() : super(isRoot: true);

  // 本方法将会在initState时调用一次
  @override
  registerVmInstance() => specProfileRegisterFunc[AuthVm].call();

  @override
  Widget build(BuildContext c, AuthVm vm) => Scaffold(body: AuthFormView());
}
