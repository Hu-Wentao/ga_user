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
class UserDateVm extends ViewModel<Either<Failure, User>> {
  final GetUser _getUser;
  final UserUploadAvatarAndUpdate _uploadAvatarAndUpdate;
  final UserUpdateNickname _updateNickName;
  final UserUpdateSex _updateSex;
  final GetAvatar _getAvatar;

//  Stream<Either<Failure, User>> _userM;
//  Stream<Either<Failure, Uint8List>> _userAvatarM;

  UserDateVm(
    this._getUser,
    this._uploadAvatarAndUpdate,
    this._updateNickName,
    this._updateSex,
    this._getAvatar,
  ) : super(create: () async => await _getUser(null)) {
//    _userM = _obsUser(null);
  }

  /// 从数据源刷新Model
  Future<void> refreshModel() async {
    final r = await _getUser(null);
    vmUpdate(r);
  }

  /// 获取头像
  Future<Either<Failure, Uint8List>> getAvatar() => _getAvatar(null);

  /// 获取昵称
  String getNickName() =>
      m?.fold<String>((f) {
        if (f is NotLoginFailure) return '尚未登陆';
        return 'error';
      }, (r) => r.nickname) ??
      'loading...';

  Sex getSex() => m?.fold<Sex>((f) => null, (r) => r?.sex);

  String getEmail() => m?.fold<String>((f) => 'error!', (r) => r?.email);

  String getPhone() => m?.fold<String>((f) => 'error!', (r) => r?.phone);

  /// 更新头像
  Future<void> updateAvatar(String nAvatarFilePath) async =>
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
