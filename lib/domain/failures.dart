// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/31
// Time  : 12:40

import 'package:get_arch_quick_start/quick_start.dart';

class UserNotFoundFailure extends Failure{
  UserNotFoundFailure({String msg}) : super('无法查询到用户', msg);
}