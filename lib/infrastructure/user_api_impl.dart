// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/19
// Time  : 23:31
import 'dart:typed_data';

import 'package:ga_user/interface/i_user_api.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_arch_quick_start/interface/i_network.dart';
import 'package:get_arch_quick_start/quick_start_part.dart';

/// 请根据自己项目的情况手动设定API, 本例只是做代码演示
/// API 属于网络数据源, 不需要try..catch,只需要返回所需的数据即可
///
/// * API 不应改对 输入/返回 的数据进行非必要加工, 只应当包含"请求方式","请求地址"两个基本要素
///   <输入>: API可以对输入数据进行必要处理, 例如[uploadAvatar], 直接传入[filePath],
///   对文件的处理包含在API实现内部.
///   <返回>: 返回的json中,如果json['data']才是DTO所需的json,在这里不允许直接 json['data']
///   而应该在repo中进出处理. 因为['data']之外的字段,如出错信息等, 也是返回信息的一部分
///   如果需要根据json['code']来判断请求结果是否有误, 推荐在[IHttp]中添加拦截器,统一拦截错误并处理
///   关于在[IHttp]实现类中添加拦截器, 参见get_arch_quick_start包中的[IHttp]Dio实现
///
//@LazySingleton(as: IUserAPI) // 手动注册
class UserAPIImpl implements IUserAPI {
  final IHttp _http;

  UserAPIImpl(this._http);

  /// 即  https://xxxx.com/v1/user/login,
  /// 其中, base url 在 [INetConfig]配置,
  /// 最终在[IHttp]实现类中应用.
  @override
  Future login(IDto dto) async => await _http.post('/v1/user/login', dto);

  @override
  Future register(IDto dto) async => await _http.post('/v1/user/register', dto);

  @override
  Future updateInfo(IDto dto) async =>
      await _http.post('/v1/user/changeInfo', dto);

  @override
  Future queryById(String uId) async => await _http.get('/v1/user/$uId');

  ///
  ///
  @override
  Future uploadAvatar(String filePath) async {
//    final fileName = filePath.split(Platform.pathSeparator).last;
    // 文件上传 - 得到图片id
    final file = await MultipartFile.fromFile(filePath);
    final imgData = FormData.fromMap({'image': file});
    return await _http.handleRequest('POST', '/v1/upload/image', data: imgData);
  }

  @override
  Future<Uint8List> queryImg(String imgId) async =>
      await _http.handleBytesRequest('GET', '/v1/image/show/$imgId');
}
