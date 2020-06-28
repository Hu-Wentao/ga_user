// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return _UserDto.fromJson(json);
}

class _$UserDtoTearOff {
  const _$UserDtoTearOff();

  _UserDto call(
      {String id,
      String username,
      String email,
      String token,
      int regTime,
      String phone,
      String avatar,
      int sex}) {
    return _UserDto(
      id: id,
      username: username,
      email: email,
      token: token,
      regTime: regTime,
      phone: phone,
      avatar: avatar,
      sex: sex,
    );
  }
}

// ignore: unused_element
const $UserDto = _$UserDtoTearOff();

mixin _$UserDto {
  String get id;
  String get username;
  String get email;
  String get token;
  int get regTime;
  String get phone;
  String get avatar;
  int get sex;

  Map<String, dynamic> toJson();
  $UserDtoCopyWith<UserDto> get copyWith;
}

abstract class $UserDtoCopyWith<$Res> {
  factory $UserDtoCopyWith(UserDto value, $Res Function(UserDto) then) =
      _$UserDtoCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String username,
      String email,
      String token,
      int regTime,
      String phone,
      String avatar,
      int sex});
}

class _$UserDtoCopyWithImpl<$Res> implements $UserDtoCopyWith<$Res> {
  _$UserDtoCopyWithImpl(this._value, this._then);

  final UserDto _value;
  // ignore: unused_field
  final $Res Function(UserDto) _then;

  @override
  $Res call({
    Object id = freezed,
    Object username = freezed,
    Object email = freezed,
    Object token = freezed,
    Object regTime = freezed,
    Object phone = freezed,
    Object avatar = freezed,
    Object sex = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      username: username == freezed ? _value.username : username as String,
      email: email == freezed ? _value.email : email as String,
      token: token == freezed ? _value.token : token as String,
      regTime: regTime == freezed ? _value.regTime : regTime as int,
      phone: phone == freezed ? _value.phone : phone as String,
      avatar: avatar == freezed ? _value.avatar : avatar as String,
      sex: sex == freezed ? _value.sex : sex as int,
    ));
  }
}

abstract class _$UserDtoCopyWith<$Res> implements $UserDtoCopyWith<$Res> {
  factory _$UserDtoCopyWith(_UserDto value, $Res Function(_UserDto) then) =
      __$UserDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String username,
      String email,
      String token,
      int regTime,
      String phone,
      String avatar,
      int sex});
}

class __$UserDtoCopyWithImpl<$Res> extends _$UserDtoCopyWithImpl<$Res>
    implements _$UserDtoCopyWith<$Res> {
  __$UserDtoCopyWithImpl(_UserDto _value, $Res Function(_UserDto) _then)
      : super(_value, (v) => _then(v as _UserDto));

  @override
  _UserDto get _value => super._value as _UserDto;

  @override
  $Res call({
    Object id = freezed,
    Object username = freezed,
    Object email = freezed,
    Object token = freezed,
    Object regTime = freezed,
    Object phone = freezed,
    Object avatar = freezed,
    Object sex = freezed,
  }) {
    return _then(_UserDto(
      id: id == freezed ? _value.id : id as String,
      username: username == freezed ? _value.username : username as String,
      email: email == freezed ? _value.email : email as String,
      token: token == freezed ? _value.token : token as String,
      regTime: regTime == freezed ? _value.regTime : regTime as int,
      phone: phone == freezed ? _value.phone : phone as String,
      avatar: avatar == freezed ? _value.avatar : avatar as String,
      sex: sex == freezed ? _value.sex : sex as int,
    ));
  }
}

@JsonSerializable()
class _$_UserDto implements _UserDto {
  _$_UserDto(
      {this.id,
      this.username,
      this.email,
      this.token,
      this.regTime,
      this.phone,
      this.avatar,
      this.sex});

  factory _$_UserDto.fromJson(Map<String, dynamic> json) =>
      _$_$_UserDtoFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String token;
  @override
  final int regTime;
  @override
  final String phone;
  @override
  final String avatar;
  @override
  final int sex;

  @override
  String toString() {
    return 'UserDto(id: $id, username: $username, email: $email, token: $token, regTime: $regTime, phone: $phone, avatar: $avatar, sex: $sex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.regTime, regTime) ||
                const DeepCollectionEquality()
                    .equals(other.regTime, regTime)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)) &&
            (identical(other.sex, sex) ||
                const DeepCollectionEquality().equals(other.sex, sex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(regTime) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(avatar) ^
      const DeepCollectionEquality().hash(sex);

  @override
  _$UserDtoCopyWith<_UserDto> get copyWith =>
      __$UserDtoCopyWithImpl<_UserDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserDtoToJson(this);
  }
}

abstract class _UserDto implements UserDto {
  factory _UserDto(
      {String id,
      String username,
      String email,
      String token,
      int regTime,
      String phone,
      String avatar,
      int sex}) = _$_UserDto;

  factory _UserDto.fromJson(Map<String, dynamic> json) = _$_UserDto.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get token;
  @override
  int get regTime;
  @override
  String get phone;
  @override
  String get avatar;
  @override
  int get sex;
  @override
  _$UserDtoCopyWith<_UserDto> get copyWith;
}
