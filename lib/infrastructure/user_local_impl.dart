// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 12:25
import 'dart:typed_data';

import 'package:ga_user/interface/dto/user_dto.dart';
import 'package:ga_user/interface/i_user_local.dart';
import 'package:get_arch_quick_start/domain/error/failures.dart';
import 'package:get_arch_quick_start/interface/i_storage.dart';

/// 实现类
/// <有缓存>
//@LazySingleton(as: IUserLocalSource) // 手动注册
class UserLocalImpl extends IUserLocal {
  final IStorage _storage;

  UserLocalImpl(this._storage);

  @override
  UserDto getCurUserDto() {
    final js = _storage.getJson(IUserLocal.k_cur_user);
    // 由于Dio异常拦截器没有StackTrace,
    // 如果拦截器调用了这里的方法并抛出异常且没有另写try..catch, 排查起来十分困难
    if (js == null) return null;
    return UserDto.fromJson(js);
  }

  @override
  setCurUserDto(UserDto dto) =>
      _storage.setJson(IUserLocal.k_cur_user, dto.toJson());

  /// 仅支持更新部分属性
  @override
  updateWith(UserDto d) {
    final cur = getCurUserDto();
    final n = cur.copyWith(
      username: d.username,
      email: d.email,
      token: d.token,
      phone: d.phone,
      avatar: d.avatar,
    );
    setCurUserDto(n);
  }

  @override
  getAvatarBytes(String photoId) =>
      photoId == null ? null : _storage.getUint8List(photoId);

  setAvatarBytes(String photoId, Uint8List img) => photoId == null
      ? throw ClientFailure.badInput('photoId is null!')
      : _storage.setUint8List(IUserLocal.k_avatar_prefix + photoId, img);

//  @override
//  ImageModelDto getImageMDto(String imgId) {
//    final json = _storage.getJson(IUserLocal.k_img_dto_prefix + imgId);
//    return ImageModelDto.fromJson(json);
//  }
//
//  @override
//  setImageMDto(ImageModelDto model) =>
//      _storage.setJson(IUserLocal.k_img_dto_prefix + model.id, model.toJson());
}
