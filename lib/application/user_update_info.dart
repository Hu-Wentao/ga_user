// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/27
// Time  : 14:31

import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/ga_user.dart';
import 'package:get_arch_core/application/i_usecase.dart';
import 'package:get_arch_quick_start/quick_start_part.dart';
import 'package:get_arch_quick_start/quick_start.dart';

///
/// 更新头像
///
@lazySingleton
class UserUploadAvatarAndUpdate extends UseCase<Unit, String> {
  final IUserRepo repo;

  UserUploadAvatarAndUpdate(this.repo);

  @override
  Future<Either<Failure, Unit>> call(String nAvatarFilePath) async {
    try {
      // 先上传图片 -得到最新的id
      final id = await repo.uploadAvatar(nAvatarFilePath);
      if (id.isLeft()) return id.map<Unit>(null);
      final idR = id.getOrElse(null);
      // 再设置头像id
      return await repo.update(User.updateInfo(avatar: idR));
    } on Failure catch (f) {
      return left(f);
    } catch (e, s) {
      return left(UnknownFailure('UserUploadAvatarAndUpdate.call:\n$e\n', s));
    }
  }
}

///
/// 更新昵称
@lazySingleton
class UserUpdateNickname extends UseCase<Unit, String> {
  final IUserRepo repo;

  UserUpdateNickname(this.repo);

  @override
  Future<Either<Failure, Unit>> call(String nNickname) async =>
      await repo.update(User.updateInfo(nickname: nNickname));
}

///
/// 更新性别
@lazySingleton
class UserUpdateSex extends UseCase<Unit, Sex> {
  final IUserRepo repo;

  UserUpdateSex(this.repo);

  @override
  Future<Either<Failure, Unit>> call(Sex nSex) async =>
      await repo.update(User.updateInfo(sex: nSex));
}

///
/// 更新Email
//@lazySingleton
//class UserUpdateEmail extends UseCase<Unit, String> {
//  final IUserRepo repo;
//
//  UserUpdateEmail(this.repo);
//
//  @override
//  Future<Either<Failure, Unit>> call(String nEmail) async =>
//      await repo.update(User.updateInfo(email: nEmail));
//}

///
/// 更新Phone
//@lazySingleton
//class UserUpdatePhone extends UseCase<Unit, String> {
//  final IUserRepo repo;
//
//  UserUpdatePhone(this.repo);
//
//  @override
//  Future<Either<Failure, Unit>> call(String nPhone) async =>
//      await repo.update(User.updateInfo(phone: nPhone));
//}

///
/// 更新密码
//@lazySingleton
//class UserUpdatePassword extends UseCase<Unit, String> {
//  final IUserRepo repo;
//
//  UserUpdatePassword(this.repo);
//
//  @override
//  Future<Either<Failure, Unit>> call(String nPwd) async {
//    await repo.update(User.updateInfo(String: nPwd));
//  }
//}
