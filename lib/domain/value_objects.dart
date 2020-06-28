// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/29
// Time  : 17:22
import 'package:dartz/dartz.dart';
import 'package:ga_user/domain/value_validators.dart';
import 'package:get_arch_core/domain/error/failures.dart';
import 'package:get_arch_core/domain/value_objects.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  EmailAddress(String value) : this.value = validateEmailAddress(value);

  @override
  String toString() => 'EmailAddress: $value';
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  Password(String value) : this.value = validatePassword(value);
}

class PhoneNumber extends ValueObject<String>{
  @override
  final Either<ValueFailure<String>, String> value;

  PhoneNumber(String value) : this.value = validatePhoneNumber(value);

}