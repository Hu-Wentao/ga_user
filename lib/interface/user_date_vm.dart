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

  UserDateVm(
    this._getUser,
    this._uploadAvatarAndUpdate,
    this._updateNickName,
    this._updateSex,
    this._getAvatar,
  ) {
    init();
  }

  init() async {
    this.m = await _getUser(null);
  }

  Map<Sex, String> get sexToString => <Sex, String>{
        Sex.male: '男',
        Sex.female: '女',
      };

  /// 从数据源刷新Model
  /// 如果是 obs用例, 推荐使用 [BaseViewModel],
  /// 当数据源刷新时,直接通过StreamBuilder自动更新UI,无需使用 [vmUpdate]
  Future<void> refreshModel() async {
    final r = await _getUser(null);
    vmUpdate(r);
  }

  /// 获取头像
  Future<Either<Failure, Uint8List>> getAvatar() => _getAvatar(null);

  /// 获取昵称
  String getNickName() =>
      m?.fold<String>((f) {
        if (f is NotLoginFailure) return '您尚未登陆';
        return 'error';
      }, (r) => r.nickname) ??
      'loading...';

  /// 获取性别
  Sex getSex() => m?.fold<Sex>((f) => null, (r) => r?.sex);

  Either<Failure, Sex> eitherSex() => m?.map<Sex>((_) => _?.sex);

  /// 获取邮箱
  String getEmail() =>
      m?.fold<String>(
          (f) => f is NotLoginFailure ? '- -' : 'error!', (r) => r?.email) ??
      '- -';

  /// 获取手机号
  String getPhone() =>
      m?.fold<String>(
          (f) => f is NotLoginFailure ? '- -' : 'error!', (r) => r?.phone) ??
      '- -';

  /// 更新头像
  Future<Failure> updateAvatar(String nAvatarFilePath) async =>
      await _uploadAvatarAndUpdate(nAvatarFilePath).asyncLeftOrNull();

  /// 更新昵称
  updateNickName(String nNickname) async => await _updateNickName(nNickname);

  /// 更新
  Future<Either<Failure, Unit>> updateSex(Sex nSex) async =>
      await _updateSex(nSex);

  /// 更新 邮箱
  updateEmail(String nEmail) {
    // todo
  }

  /// 更新 手机号
  updatePhone(String nPhone) {
    // todo
  }
}
