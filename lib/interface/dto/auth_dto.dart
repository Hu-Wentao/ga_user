// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/31
// Time  : 0:42

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ga_user/domain/value_objects.dart';
import 'package:gat_env_info/interface/dto/dto.dart';
import 'package:get_arch_core/interface/i_common_interface.dart';

part 'auth_dto.freezed.dart';
part 'auth_dto.g.dart';

///
/// 这里作为 Dto的 AuthDto并没有对应domain中的某一个类, 只是作为登陆/注册的参数
@freezed
abstract class AuthDto extends IDto with _$AuthDto {
  factory AuthDto({
    String email,
    String password,
    EnvInfoDto env,
  }) = _AuthDto;

  factory AuthDto.fromDomain(EmailAddress email, Password password,
      EnvInfoDto envDto) =>
      AuthDto(
        email: email.getOrCrash(),
        password: password.getOrCrash(),
        env: envDto,
      );

  factory AuthDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDtoFromJson(json);
}

extension AuthDtoX on AuthDto {
  Map<String, dynamic> toJson() =>
      this.toJson()..removeWhere((key, value) => value == null);
}
