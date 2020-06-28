// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/19
// Time  : 23:31
import 'package:ga_user/interface/i_user_api.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_arch_core/interface/i_common_interface.dart';
import 'package:injectable/injectable.dart';

/// 请根据自己项目的情况手动设定API, 本例只是做代码演示
@LazySingleton(as: IUserAPI)
class UserAPI implements IUserAPI {
  final IHttp _http;

  UserAPI(this._http);

  @override
  Future login(IDto dto) => _http.post('/user/login', dto);

  @override
  Future register(IDto dto) => _http.post('/user/register', dto);
}
