// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserDto _$_$_UserDtoFromJson(Map<String, dynamic> json) {
  return _$_UserDto(
    id: json['id'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    token: json['token'] as String,
    phone: json['phone'] as String,
    avatar: json['avatar'] as String,
    sex: json['sex'] as int,
    regTime: json['regTime'] as int,
  );
}

Map<String, dynamic> _$_$_UserDtoToJson(_$_UserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'token': instance.token,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'sex': instance.sex,
      'regTime': instance.regTime,
    };
