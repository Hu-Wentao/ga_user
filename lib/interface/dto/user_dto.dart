// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/27
// Time  : 19:05

import 'package:ga_user/domain/entities/user.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto extends IDto with _$UserDto {
  factory UserDto({
    String id,
    String username,
    String email,
    String token,
    String phone,
    String avatar,
    int sex,
    int regTime,
  }) = _UserDto;

  factory UserDto.fromDomain(User d) => UserDto(
        id: d.id,
        username: d.nickname,
        email: d.email,
        token: d.token,
        phone: d.phone,
        avatar: d.avatar,
        sex: d.sex.index,
        regTime: d.regTime,
      );

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

extension UserDtoX on UserDto {
  User toDomain() => User.fromResult(
        id: id,
        nickname: username,
        email: email == null ? null : email,
        token: token,
        regTime: regTime,
        phone: phone == null ? null : phone,
        avatar: avatar,
        sex: Sex.values[sex],
      );

  Map<String, dynamic> toJson() =>
      this.toJson()..removeWhere((key, value) => value == null);
}
