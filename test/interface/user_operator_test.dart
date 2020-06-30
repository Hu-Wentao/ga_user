// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/15
// Time  : 9:28
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ga_user/domain/value_objects.dart';
import 'package:ga_user/ga_user.dart';
import 'package:ga_user/profile/user_package.dart';
import 'package:get_arch_core/domain/env_config.dart';
import 'package:get_arch_core/get_arch_core.dart';

main() async {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDI(EnvSign.test);
  });

//  final p = AuthDto.fromDomain(
//      EmailAddress('hu.wt@qq.com'),
//      Password('123123'),
//      EnvInfoDto.fromDomain(EnvInfo.otherPlatform('e', 'platform')));
  final p =
      User.authWithEmail(EmailAddress('hu.wt@qq.com'), Password('123123'));
//║    {
//║         code: "0",
//║         message: "SUCCESS",
//║         data: {
//║             username: "hu.wt@qq.com",
//║             sex: 1,
//║             avatar: null,
//║             email: "hu.wt@qq.com",
//║             regTime: 1592185142947,
//║             token: "zFW1kCD5siW0VBy2edpv5g==",
//║             id: "fe2384daaea811eaa8844ad3bcd5ad06"
//║        }
//║    }
  test('注册', () async {
    final reg = GetIt.I<UserRegister>();
    final r = await reg(p);
    expect(r.isRight(), true);
  });

  test('登陆', () async {
    final login = GetIt.I<UserLogin>();
    final r = await login(p);
    expect(r.isRight(), true);
  });
}
