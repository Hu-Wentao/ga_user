// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'auth_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
AuthDto _$AuthDtoFromJson(Map<String, dynamic> json) {
  return _AuthDto.fromJson(json);
}

class _$AuthDtoTearOff {
  const _$AuthDtoTearOff();

// ignore: unused_element
  _AuthDto call({String email, String password, EnvInfoDto env}) {
    return _AuthDto(
      email: email,
      password: password,
      env: env,
    );
  }
}

// ignore: unused_element
const $AuthDto = _$AuthDtoTearOff();

mixin _$AuthDto {
  String get email;
  String get password;
  EnvInfoDto get env;

  Map<String, dynamic> toJson();
  $AuthDtoCopyWith<AuthDto> get copyWith;
}

abstract class $AuthDtoCopyWith<$Res> {
  factory $AuthDtoCopyWith(AuthDto value, $Res Function(AuthDto) then) =
      _$AuthDtoCopyWithImpl<$Res>;
  $Res call({String email, String password, EnvInfoDto env});

  $EnvInfoDtoCopyWith<$Res> get env;
}

class _$AuthDtoCopyWithImpl<$Res> implements $AuthDtoCopyWith<$Res> {
  _$AuthDtoCopyWithImpl(this._value, this._then);

  final AuthDto _value;
  // ignore: unused_field
  final $Res Function(AuthDto) _then;

  @override
  $Res call({
    Object email = freezed,
    Object password = freezed,
    Object env = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      env: env == freezed ? _value.env : env as EnvInfoDto,
    ));
  }

  @override
  $EnvInfoDtoCopyWith<$Res> get env {
    if (_value.env == null) {
      return null;
    }
    return $EnvInfoDtoCopyWith<$Res>(_value.env, (value) {
      return _then(_value.copyWith(env: value));
    });
  }
}

abstract class _$AuthDtoCopyWith<$Res> implements $AuthDtoCopyWith<$Res> {
  factory _$AuthDtoCopyWith(_AuthDto value, $Res Function(_AuthDto) then) =
      __$AuthDtoCopyWithImpl<$Res>;
  @override
  $Res call({String email, String password, EnvInfoDto env});

  @override
  $EnvInfoDtoCopyWith<$Res> get env;
}

class __$AuthDtoCopyWithImpl<$Res> extends _$AuthDtoCopyWithImpl<$Res>
    implements _$AuthDtoCopyWith<$Res> {
  __$AuthDtoCopyWithImpl(_AuthDto _value, $Res Function(_AuthDto) _then)
      : super(_value, (v) => _then(v as _AuthDto));

  @override
  _AuthDto get _value => super._value as _AuthDto;

  @override
  $Res call({
    Object email = freezed,
    Object password = freezed,
    Object env = freezed,
  }) {
    return _then(_AuthDto(
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      env: env == freezed ? _value.env : env as EnvInfoDto,
    ));
  }
}

@JsonSerializable()
class _$_AuthDto implements _AuthDto {
  _$_AuthDto({this.email, this.password, this.env});

  factory _$_AuthDto.fromJson(Map<String, dynamic> json) =>
      _$_$_AuthDtoFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final EnvInfoDto env;

  @override
  String toString() {
    return 'AuthDto(email: $email, password: $password, env: $env)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthDto &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.env, env) ||
                const DeepCollectionEquality().equals(other.env, env)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(env);

  @override
  _$AuthDtoCopyWith<_AuthDto> get copyWith =>
      __$AuthDtoCopyWithImpl<_AuthDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AuthDtoToJson(this);
  }
}

abstract class _AuthDto implements AuthDto {
  factory _AuthDto({String email, String password, EnvInfoDto env}) =
      _$_AuthDto;

  factory _AuthDto.fromJson(Map<String, dynamic> json) = _$_AuthDto.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  EnvInfoDto get env;
  @override
  _$AuthDtoCopyWith<_AuthDto> get copyWith;
}
