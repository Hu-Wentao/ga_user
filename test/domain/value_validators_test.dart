// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/29
// Time  : 18:10
import 'package:flutter_test/flutter_test.dart';
import 'package:ga_user/domain/value_validators.dart';

main() {
  test("测试邮箱验证器", () {
    String e;
//    String e = '123.4';
    var r = validateEmailAddress(e);

    print('main $r');
  });
}
