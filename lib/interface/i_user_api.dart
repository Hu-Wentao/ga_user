// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/13
// Time  : 21:11

import 'package:get_arch_core/interface/i_common_interface.dart';

///
/// API 属于网络源
/// 输入参数, 返回json
/// 实现类主要确定请求路径以及请求方法(get,post等)
abstract class IUserAPI {
  Future register(IDto dto);

  Future login(IDto dto);
}
