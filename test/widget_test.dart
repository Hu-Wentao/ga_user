// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/28
// Time  : 22:14

import 'package:flutter/material.dart';
import 'package:ga_user/ga_user.dart';
import 'package:get_arch_core/domain/env_config.dart';
import 'package:get_arch_core/get_arch_core.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetArchApplication.run(EnvConfig.sign(EnvSign.prod), packages: [
    UserPackage(),
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('User模块测试页'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('进入登陆/注册页'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AuthPage()),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
