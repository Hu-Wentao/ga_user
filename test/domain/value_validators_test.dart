// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/29
// Time  : 18:10
import 'package:flutter_test/flutter_test.dart';
import 'package:ga_user/domain/value_validators.dart';
import 'package:get_arch_core/get_arch_part.dart' show ValidatorUtils;

main() {
  test("测试邮箱验证器", () {
//    String e;
    String e = '123.4';
    final r = vEmail().verify(e);
    expect(r.isRight(), true);
  });
}
