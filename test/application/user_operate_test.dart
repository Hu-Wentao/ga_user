// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/27
// Time  : 14:52

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ga_user/application/login.dart';
import 'package:ga_user/application/register.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:ga_user/domain/value_objects.dart';
import 'package:ga_user/interface/i_user_local.dart';
import 'package:ga_user/profile/user_package.dart';
import 'package:get_arch_core/domain/env_config.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:mockito/mockito.dart';

class MockUserDataSource extends Mock implements IUserLocal {}

class MockUserRepo extends Mock implements IUserRepo {}

main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDI( EnvSign.test);
  });
  test('测试用户注册', () async {
    final userRepo = MockUserRepo();

    final registerUseCase = UserRegister(userRepo);

    // 获取返回值
    final result = await registerUseCase(
        User.authWithEmail(EmailAddress('hu.wt@qq.com'), Password('123123')));

    // assert
    expect(result, null);
  });
  test('测试用户登陆', () async {
    final loginUseCase = GetIt.I<UserLogin>();
//    final loginUseCase = UserLogin(userRepo);

    // 获取返回值
    final result = await loginUseCase(
        User.authWithEmail(EmailAddress('hu.wt@qq.com'), Password('123123')));
    // assert
    expect(result, null);
  });
}
