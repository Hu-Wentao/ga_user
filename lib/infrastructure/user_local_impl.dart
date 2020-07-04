// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/2/28
// Time  : 12:25
import 'package:ga_user/interface/dto/user_dto.dart';
import 'package:ga_user/interface/i_user_local.dart';
import 'package:get_arch_quick_start/interface/i_storage.dart';

/// 实现类
/// <有缓存>
//@LazySingleton(as: IUserLocalSource) // 手动注册
class UserLocalImpl extends IUserLocal {
  final IStorage storage;
  UserDto _cacheDto;

  UserLocalImpl(this.storage);

  @override
  UserDto getCurUserDto() {
    if (_cacheDto != null) return _cacheDto;

    final js = storage.getJson(IUserLocal.k_cur_user);
    // 由于Dio异常拦截器没有StackTrace,
    // 如果拦截器调用了这里的方法并抛出异常且没有另写try..catch, 排查起来十分困难
    if (js == null) return null;
    return UserDto.fromJson(js);
  }

  @override
  setCurUserDto(UserDto dto) {
    _cacheDto = dto;

    final js = dto.toJson();
    storage.setJson(IUserLocal.k_cur_user, js);
  }

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
}
