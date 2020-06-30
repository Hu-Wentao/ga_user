// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 12:25
import 'package:ga_user/interface/dto/user_dto.dart';
import 'package:ga_user/interface/i_user_local.dart';
import 'package:get_arch_core/get_arch_core.dart';

/// 实现类
/// <有缓存>
//@LazySingleton(as: IUserLocalSource) // 手动注册
class UserLocalImpl extends IUserLocal {
  final IStorage storage;
  UserDto _cacheDto;

  UserLocalImpl(this.storage);

  @override
  UserDto getCurUserDto() {
    if(_cacheDto!=null) return _cacheDto;

    final jString = storage.getJson(IUserLocal.k_cur_user);
    if (jString == null) return null;
    return UserDto.fromJson(jString);
  }

  @override
  setCurUserDto(UserDto dto) {
    _cacheDto = dto;

    final js = dto.toJson();
    storage.setJson(IUserLocal.k_cur_user, js);
  }
}
