// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/6
// Time  : 17:29


import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_arch_quick_start/quick_start_part.dart';

class UploadAvatar extends UseCase<Unit, String> {
  final IUserRepo _repo;
  UploadAvatar(this._repo);
  @override
  Future<Either<Failure, Unit>> call(String path) async {
    // todo 上传头像之后, 获取到头像的id, 然后再更新用户的头像id
    return _repo.uploadAvatar(path);
  }
}
