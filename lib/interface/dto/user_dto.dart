// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/27
// Time  : 19:05

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/value_objects.dart';
import 'package:get_arch_core/interface/i_common_interface.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto extends IDto with _$UserDto {
  factory UserDto({
    String id,
    String username,
    String email,
    String token,
    int regTime,
    String phone,
    String avatar,
    int sex,
  }) = _UserDto;

  factory UserDto.fromDomain(User u) => UserDto(
        id: u.id,
        username: u.nickname,
        email: u.email.getOrElse(null),
        token: u.token,
        regTime: u.regTime,
        phone: u.phone.getOrElse(null),
        avatar: u.avatar,
        sex: u.sex.index,
      );

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

extension UserDtoX on UserDto {
  User toDomain() => User.fromResult(
        id: id,
        nickname: username,
        email: email == null ? null : EmailAddress(email),
        token: token,
        regTime: regTime,
        phone: phone == null ? null : PhoneNumber(phone),
        avatar: avatar,
        sex: Sex.values[sex],
      );

  Map<String, dynamic> toJson() =>
      this.toJson()..removeWhere((key, value) => value == null);
}
