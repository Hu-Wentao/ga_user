// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/4
// Time  : 19:22
import 'dart:typed_data';

import 'package:ga_user/application/get_avatar.dart';
import 'package:ga_user/application/get_user.dart';
import 'package:ga_user/application/upload_avatar.dart';
import 'package:ga_user/application/user_update_info.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/interface/dto/user_dto.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_state/get_state.dart';

//@lazySingleton v
class UserDateVm extends ViewModel<User> {
  final GetUser getUser;
  final UserUpdateInfo _updateInfo;
  final UploadAvatar _uploadAvatar;
  final GetAvatar _getAvatar;

  UserDateVm(
      this._updateInfo, this.getUser, this._uploadAvatar, this._getAvatar)
      : super(() async => (await getUser(null)).getOrElse(() => null));

  /// 获取头像
  Future<Either<Failure, Uint8List>> get getAvatar => _getAvatar(null);

  /// 更新头像
  Future updateAvatar(String nAvatarFilePath) async =>
      await _uploadAvatar(nAvatarFilePath);

  /// 更新昵称
  updateNickName(String nNickname) async {
    User n = UserDto.fromDomain(m).copyWith(username: nNickname).toDomain();
    _updateInfo(n);
  }

  /// 更新
  updateSex(Sex nSex) {
    User n = UserDto.fromDomain(m).copyWith(sex: nSex.index).toDomain();
    _updateInfo(n);
  }

  /// 更新
  updateEmail(String nEmail) {
    User n = UserDto.fromDomain(m).copyWith(email: nEmail).toDomain();
    _updateInfo(n);
  }

  /// 更新
  updatePhone(String nPhone) {
    User n = UserDto.fromDomain(m).copyWith(email: nPhone).toDomain();
    _updateInfo(n);
  }
}
