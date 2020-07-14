// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/27
// Time  : 14:52

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ga_user/application/upload_avatar.dart';
import 'package:ga_user/application/user_login.dart';
import 'package:ga_user/application/user_register.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:ga_user/ga_user.dart';
import 'package:ga_user/interface/i_user_local.dart';
import 'package:get_arch_core/domain/env_config.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_arch_quick_start/interface/i_network.dart';
import 'package:get_arch_quick_start/interface/i_storage.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:mockito/mockito.dart';

class MockUserDataSource extends Mock implements IUserLocal {}

class MockUserRepo extends Mock implements IUserRepo {}

class MockHttp extends Mock implements IHttp {
  Future<dynamic> post(String tailUrl, IDto dataDto) async {
    final js = json.decode(r"""{
  "code": "0",
  "message": "SUCCESS",
  "data": {
  "username": "abcabc",
  "sex": 1,
  "avatar": null,
  "email": "hu.wt@qq.com",
  "regTime": 1593070236048,
  "token": "wGtJbzufO4Jegv8WL*nDyQ==",  
  "id": "c2bc529fb6b511eaa8844ad3bcd5ad06"
  }
  }""");

    return js;
  }
}

class MockStorage extends Mock implements IStorage {}

class MockUserAPI extends Mock implements IUserAPI {}

main() {

  /// 搭建环境用于测试
  /// 如果用例注册配置代码完备的话, 可以替换在EnvSign后,运行main中的注册代码
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetArchApplication.run(EnvConfig.sign(EnvSign.dev), packages: [
      UserPackage(
        pkgEnv: EnvConfig.sign(EnvSign.prod),
        openIUserAPI: true,
        specProfile: {
          'UserLogin': true,
        },
      ),
    ]);
    GetIt.I.registerSingleton<IHttp>(MockHttp());
    GetIt.I.registerSingleton<IStorage>(MockStorage());
  });
  test('测试用户注册', () async {
    final userRepo = MockUserRepo();

    final registerUseCase = UserRegister(userRepo);

    // 获取返回值
    final result =
        await registerUseCase(User.authWithEmail('hu.wt@qq.com', '123123'));

    // assert
    expect(result, null);
  });
  test('测试用户登陆', () async {
    final loginUseCase = GetIt.I<UserLogin>();
//    final loginUseCase = UserLogin(userRepo);

    // 获取返回值
    final result =
        await loginUseCase(User.authWithEmail('hu.wt@qq.com', '123123'));
    // assert
    expect(result.isRight(), true);
  });
  test('测试用户更新信息', () async {
    final uc = GetIt.I<UserUpdateInfo>();

    // 获取返回值
    final result = await uc(User.updateInfo(nickname: 'rename'));
    // assert
    expect(result, null);
  });

  test('测试头像上传',() async {
    final uc = GetIt.I<UploadAvatar>();
    final r = await uc(r'2.png');
    print('main#$r');
  });
}
