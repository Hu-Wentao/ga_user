// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/29
// Time  : 18:07

import 'package:dartz/dartz.dart';
import 'package:get_arch_core/domain/error/failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  if (input == null && input == '')
    return left(ValueFailure.invalidEmail(failedValue: '输入值不能为空'));
  const emailRegex =
  r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input == null && input == '')
    return left(ValueFailure.invalidEmail(failedValue: '输入值不能为空'));
  //这里还可以添加更多的自定义规则,如 "不能是纯数字"等
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePhoneNumber(String input) {
  if (input == null && input == '')
    return left(ValueFailure.invalidEmail(failedValue: '输入值不能为空'));

  //这里还可以添加更多的自定义规则,如 "不能是纯数字"等
  if (input.length == 11 && input.startsWith('1')) {
    return right(input);
  } else {
    return left(ValueFailure.invalidPhoneNumber(failedValue: input));
  }
}
