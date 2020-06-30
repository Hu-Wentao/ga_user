// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_AuthDto _$_$_AuthDtoFromJson(Map<String, dynamic> json) {
  return _$_AuthDto(
    email: json['email'] as String,
    password: json['password'] as String,
    env: json['env'] == null
        ? null
        : EnvInfoDto.fromJson(json['env'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_AuthDtoToJson(_$_AuthDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'env': instance.env,
    };
