// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/19
// Time  : 23:31
import 'package:ga_user/interface/i_user_api.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_arch_core/interface/i_common_interface.dart';

/// 请根据自己项目的情况手动设定API, 本例只是做代码演示
/// API 属于网络数据源, 不需要try..catch,只需要返回所需的数据即可
/// 可以对返回的数据进行加工, 例如:
///   返回的json中,json['data']才是DTO所需的json,那么可以在这里直接 json['data']
///   如果需要根据json['code']来判断请求结果是否有误, 推荐在[IHttp]中添加拦截器,统一拦截错误并处理
///   关于在[IHttp]实现类中添加拦截器, 请查看get_arch_quick_start包中的[IHttp]Dio实现
//@LazySingleton(as: IUserAPI) // 手动注册
class UserAPIImpl implements IUserAPI {
  final IHttp _http;

  UserAPIImpl(this._http);

  /// 即  https://xxxx.com/v1/user/login,
  /// 其中, base url 在 [INetConfig]配置,
  /// 最终在[IHttp]实现类中应用.
  @override
  Future login(IDto dto) async => (await _http.post('/v1/user/login', dto))['data'];

  @override
  Future register(IDto dto) async => (await _http.post('/v1/user/register', dto))['data'];
}
