// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/4
// Time  : 19:22
import 'dart:typed_data';

import 'package:ga_user/application/get_avatar.dart';
import 'package:ga_user/application/get_user.dart';
import 'package:ga_user/application/user_update_info.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_state/get_state.dart';

//@lazySingleton v
class UserDateVm extends ViewModel {
  final ObsUser _obsUser;
  final UserUploadAvatarAndUpdate _uploadAvatarAndUpdate;
  final UserUpdateNickname _updateNickName;
  final UserUpdateSex _updateSex;
  final GetAvatar _getAvatar;

  LiveModel<User> _userM;
  LiveModel<Uint8List> _userAvatarM;

  UserDateVm(
    this._obsUser,
    this._uploadAvatarAndUpdate,
    this._updateNickName,
    this._updateSex,
    this._getAvatar,
  ) {
    _userM = _obsUser(null);
  }

  /// 获取头像
  Stream<Either<Failure, Uint8List>> getAvatar() => _userAvatarM.obsData;

  /// 获取昵称
  String getNickName() => _userM.snapFold<String>(
      onNull: () => 'loading...',
      onFailure: (f) {
        if (f is NotLoginFailure) return '尚未登陆';
        return 'error';
      },
      onData: (r) => r.nickname);

  Sex getSex() =>
      _userM.snapFold<Sex>(onFailure: (f) => null, onData: (r) => r?.sex);

  String getEmail() => _userM.snapFold<String>(
      onFailure: (f) => 'error!', onData: (r) => r?.email);

  String getPhone() => _userM.snapFold<String>(
      onFailure: (f) => 'error!', onData: (r) => r?.phone);

  /// 更新头像
  updateAvatar(String nAvatarFilePath) async =>
      await _uploadAvatarAndUpdate(nAvatarFilePath);

  /// 更新昵称
  updateNickName(String nNickname) async => await _updateNickName(nNickname);

  /// 更新
  updateSex(Sex nSex) async => await _updateSex(nSex);

  /// 更新
  updateEmail(String nEmail) {
    // todo
  }

  /// 更新
  updatePhone(String nPhone) {
    // todo
  }
}
