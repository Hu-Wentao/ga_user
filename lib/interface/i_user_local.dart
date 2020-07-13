// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/13
// Time  : 21:11

import 'dart:typed_data';

import 'dto/user_dto.dart';

///
/// 存储用户信息
abstract class IUserLocal {
  static const k_cur_user = 'k_cur_user';
  static const k_avatar_prefix = 'k_avatar_prefix';
  static const k_img_dto_prefix = 'k_img_dto_prefix';
  static const k_img_bytes_prefix = 'k_img_bytes_prefix';

  /// 获取当前已登陆用户
  UserDto getCurUserDto();

  /// 存储用户到本地，并设为当前已登陆用户
  setCurUserDto(UserDto dto);

  updateWith(UserDto dto);

  getAvatarBytes(String imgId);

  setAvatarBytes(String imgId, Uint8List img);

//  ImageModelDto getImageMDto(String imgId);
//
//  setImageMDto(ImageModelDto model);
}
