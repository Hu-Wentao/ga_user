// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/4/1
// Time  : 20:14
import 'package:flutter_test/flutter_test.dart';
import 'package:ga_user/domain/value_objects.dart';

main() {
  test('password', (){
    Password p1 = Password('123123');
    Password p2= Password('123123');
    Password p3= Password('1231');
    print('${p1==p2}');
    print('${p1==p3}');
    expect(p1==p2, true);
    expect(p1==p3, false);
  });
}