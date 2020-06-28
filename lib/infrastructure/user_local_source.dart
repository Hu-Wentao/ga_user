// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 12:25
import 'package:ga_user/interface/dto/user_dto.dart';
import 'package:ga_user/interface/i_user_source.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:injectable/injectable.dart';

/// 实现类
@LazySingleton(as: IUserLocalSource)
class UserLocalSource extends IUserLocalSource {
  final IStorage storage;

  UserLocalSource(this.storage);


  @override
  UserDto getCurUserDto() {
    final jString = storage.getJson(IUserLocalSource.k_cur_user);
    if (jString == null) return null;
    return UserDto.fromJson(jString);
  }

  @override
  setCurUserDto(UserDto dto) {
    final js = dto.toJson();
    storage.setJson(IUserLocalSource.k_cur_user, js);
  }
}
