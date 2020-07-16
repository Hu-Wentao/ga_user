// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/11
// Time  : 13:13

import 'package:flutter_test/flutter_test.dart';
import 'package:ga_user/infrastructure/user_api_impl.dart';
import 'package:get_arch_quick_start/quick_start.dart';

main() {
//  final g = GetIt.I;
//  setUpAll(() {
//    GetArchApplication.run(null, packages: [
//      UserPackage(),
//    ]);
//  });

  test('上传图片uploadAvatar', () async {
    final userApi =
        UserAPIImpl(HttpImpl(HttpConfig('http', 'xxx.xxx.xx.xx', null)));
    final r = await userApi.uploadAvatar(r'2.png');
    print('main #r$r');
  });
}
