// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/11
// Time  : 0:18

import 'dart:typed_data';

import 'package:ga_user/application/get_user.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:ga_user/ga_user.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_arch_quick_start/quick_start_part.dart';

///
/// [imgId] 为null,  表示获取当前用户的头像
// 已手动注册
class GetAvatar extends UseCase<Uint8List, String> {
  final IUserRepo _userRepo;
  final GetUser _getUser;

  GetAvatar(this._userRepo, this._getUser);
  @override
  Future<Either<Failure, Uint8List>> call(String imgId) async {
    if (imgId == null) {
      // 获取当前用户的头像
      final user = await _getUser(null);
      if (user.isLeft()) return user.map<Uint8List>(null);
      final userR = user.getOrElse(null);
      imgId = userR.avatar;
      if(imgId == null){
        return left(null); // todo 这里返回的是null,可能会出错
      }
    }
    return _userRepo.getAvatar(imgId);
  }
}
