// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/29
// Time  : 17:57
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ga_user/interface/dto/user_dto.dart';
import 'package:ga_user/interface/i_user_local.dart';
import 'package:ga_user/profile/user_package.dart';
import 'package:get_arch_core/domain/env_config.dart';
import 'package:get_arch_core/get_arch_core.dart';

main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetArchApplication.run(EnvConfig.sign(EnvSign.prod), packages: [
      UserPackage(),
    ]);
  });
  test("规范测试UserSource", () async {
    IUserLocal source = GetIt.I<IUserLocal>();
//    await source.testInit();

    final UserDto model = UserDto.fromJson({
      "userInfo": {
        "username": "hu.wt@qq.com",
        "email": "hu.wt@qq.com",
        "id": "0a22cc35596b11eaa02f00ff505b6d39"
      },
      "token": "ck55eaBHolswn0b5Bmnb1w=="
    });

    source.setCurUserDto(model);

    UserDto r = source.getCurUserDto();

    print(r);
    expect(r, model);
  });
}
