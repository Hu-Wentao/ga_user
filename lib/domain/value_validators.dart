// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/29
// Time  : 18:07

import 'package:get_arch_core/get_arch_part.dart';

// todo 移动到 core中
class ValidateError extends Error with ValidationError {
  @override
  final String errorDescription;
  ValidateError(this.errorDescription);
}

// todo 移动到 core中
/// 验证值不为null或空
Validator_<String> vStrNotEmpty([String errMsg = '字符串不能为null或空']) =>
    Verify.property((str) => str?.isNotEmpty ?? false,
        error: ValidateError(errMsg));
// todo 移动到 core中
/// 验证值的长度在区间 [min,max] 内
Validator_<String> vStrLength([min = 0, max = 256, String errMsg]) =>
    Verify.property((str) => str.length >= min && str.length <= max,
        error: ValidateError(errMsg ?? '字符串长度不在区间[$min,$max]内'));

const _emailRegex =
    r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

/// 检查邮箱是否合规
Validator_<String> vEmail({String onEmpty, String onNotEmail}) => Verify.all([
      vStrNotEmpty(onEmpty),
      RegExp(_emailRegex).matchOr(ValidateError(onNotEmail)),
    ]);

Validator_<String> vPassword({String onEmpty, String onWrongLength}) =>
    Verify.all([
      vStrNotEmpty(onEmpty ?? '密码不能为空'),
      vStrLength(6, 32, onWrongLength ?? '密码长度必须在6到32位之间'),
    ]);

Validator_<String> vPhoneNumber(
        {String onEmpty: '手机号不能为空', String onWrongLength: '手机号长度错误'}) =>
    Verify.all([
      vStrNotEmpty(onEmpty),
      vStrLength(11, 11, onWrongLength),
    ]);
