// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/1
// Time  : 12:48

import 'package:flutter/material.dart';
import 'package:ga_user/interface/auth_view_model.dart';
import 'package:get_state/get_state.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

///
/// 由于AuthVm是注册在AuthPage中的,
/// 因此将 [AuthFormView]标记为 RootView
class AuthFormView extends View<AuthVm> {

  @override
  Widget build(c, vm) => Form(
      autovalidate: vm.isAutoValidate,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 22.0),
        children: <Widget>[
          const SizedBox(height: kToolbarHeight),
          TitleAndLine(isLogin: vm.isLogin),
          const SizedBox(height: 60.0),
          emailTF(vm),
          const SizedBox(height: 30.0),
          PasswordTF(),
          vm.isLogin ? ForgetPassword() : reInputPasswordTF(c, vm),
          const SizedBox(height: 50.0),
          loginOrRegisterBtn(c, vm),
          const SizedBox(height: 35.0),
          const _OtherLogin(),
          toggleLoginOrRegister(c, vm),
        ],
      ));

  static TextFormField emailTF(AuthVm vm) => TextFormField(
        decoration: InputDecoration(
          labelText: '邮箱', //note： 考虑支持手机号登陆、注册
        ),
        autocorrect: false,
        onChanged: (value) => vm.onEmailChanged(value),
        validator: (_) => vm.emailAddress?.value?.fold(
            (e) => e.maybeMap(
                invalidEmail: (_) => _.failedValue.isEmpty ? '请输入邮箱' : '邮箱格式错误',
                orElse: () => '未知原因出错'),
            (_) => null),
      );

  static Widget reInputPasswordTF(BuildContext c, AuthVm vm) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
        child: TextFormField(
          onChanged: (String value) => vm.onRePwdChanged(value),
          obscureText: vm.isPwdObscure,
          validator: (pwd) => _pwdCheck(pwd, true, vm),
          decoration: InputDecoration(
              labelText: '再次输入',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: vm.isPwdObscure
                      ? Colors.grey
                      : Theme.of(c).iconTheme.color,
                ),
                onPressed: () => vm.onTogglePwdObscure(),
              )),
        ),
      );

  static Widget loginOrRegisterBtn(BuildContext c, AuthVm vm) => Align(
        child: SizedBox(
          height: 45.0,
          width: 270.0,
          child: RaisedButton(
            child: Text(
              vm.isLogin ? '登陆' : "注册",
              style: Theme.of(c).primaryTextTheme.headline5,
            ),
            color: Colors.black,
            onPressed: () async {
              bool r = await vm.loginOrRegister();
              // 认证成功后返回 true 否则会返回null或者false
              if (r != null && r) Navigator.pop(c, true);
            },
            shape: StadiumBorder(side: BorderSide()),
          ),
        ),
      );

  static Widget toggleLoginOrRegister(BuildContext c, AuthVm vm) => Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(vm.isLogin ? '没有账号?' : '已有账号?'),
              FlatButton(
                child: Text(
                  vm.isLogin ? "注册" : "登陆",
                  style: TextStyle(color: Theme.of(c).primaryColor),
                ),
                onPressed: () => vm.onToggleLoginOrRegister(),
              ),
            ],
          ),
        ),
      );
}

/// 检查密码输入是否正确
_pwdCheck(input, isRePwd, AuthVm vm) {
  if (input.isEmpty) {
    return '请输入密码';
  } else if (isRePwd && !vm.isPwdEqual) {
    return '两次密码不匹配';
  } else if (isRePwd) {
    return vm.rePassword?.value?.fold(
      (e) => e.maybeMap(shortPassword: (_) => '请再次输入密码', orElse: () => '未知错误'),
      (_) => null,
    );
  } else {
    return vm.password?.value?.fold(
        (f) => f.maybeMap(
            shortPassword: (_) => _.failedValue.isEmpty ? '请输入密码' : '密码过短!',
            orElse: () => '未知错误'),
        (_) => null);
  }
}

class TitleAndLine extends StatelessWidget {
  final bool isLogin;

  const TitleAndLine({Key key, this.isLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              isLogin ? "登陆" : "注册",
              style: TextStyle(fontSize: 42.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.0, top: 1.0),
            child: Align(
              alignment: Alignment.bottomLeft,
//            alignment: _isLogin ? Alignment.bottomLeft : Alignment.bottomRight,
              child: Container(
                color: Colors.black,
                width: 40.0,
                height: 3.0,
              ),
            ),
          ),
        ],
      );
}

class PasswordTF extends View<AuthVm> {
  @override
  Widget build(c, vm) => TextFormField(
      obscureText: vm.isPwdObscure,
      onChanged: (value) => vm.onPasswordChanged(value),
      validator: (pwd) => _pwdCheck(pwd, false, vm),
      decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color:
                  vm.isPwdObscure ? Colors.grey : Theme.of(c).iconTheme.color,
            ),
            onPressed: () => vm.onTogglePwdObscure(),
          )));
}

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            "忘记密码?",
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () => Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('敬请期待...'), // todo "忘记密码"
          )),
        ),
      ),
    );
  }
}

class _OtherLogin extends StatelessWidget {
  final List _loginMethod = const [
    {
      "title": "谷歌",
      "icon": GroovinMaterialIcons.google,
    },
    {
      "title": "QQ",
      "icon": GroovinMaterialIcons.qqchat,
    },
    {
      "title": "微信",
      "icon": GroovinMaterialIcons.wechat,
    },
  ];

  const _OtherLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '其他',
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            )),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: _loginMethod
              .map((item) => Builder(
                    builder: (context) => IconButton(
                        icon: Icon(item['icon'],
                            color: Theme.of(context).hintColor),
                        onPressed: () {
                          //TODO : 第三方登录方法
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: Text("${item['title']} 登陆"),
                            action: new SnackBarAction(
                              label: '敬请期待...',
                              onPressed: () {},
                            ),
                          ));
                        }),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
