// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/26
// Time  : 23:41

import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:ga_user/infrastructure/user_api_impl.dart';
import 'package:ga_user/infrastructure/user_local_source.dart';
import 'package:ga_user/interface/i_user_api.dart';
import 'package:ga_user/interface/i_user_source.dart';
import 'package:ga_user/interface/user_repo_impl.dart';
import 'package:gat_env_info/interface/i_env_info_source.dart';
import 'package:gat_env_info/profile/env_info_package.dart';
import 'package:get_arch_core/domain/env_config.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_arch_core/get_arch_part.dart';

import 'user_package.iconfig.dart';

GetIt _g = GetIt.I;

///
/// [pkgEnv] 建议仅供测试添加, 不赋值时默认使用全局EnvConfig
///
/// 以下bool型变量如果设为false,则表示你需要手动实现并注册对应的接口,
/// 注册接口是不分时间先后的,先加载本模块,然后再加载主项目中自己的实现, 也是没有问题的.
///
/// [openIUserAPI] 用户API实现, 默认false! 请参照源码,实现自己的IUserAPI
///
/// [openIUserRepo] 是否开启IUserRepo, 默认true
/// [openIUserLocalSource] 本地用户存储实现, 默认true
/// [openIEnvInfoSource] 是否使用默认的IEnvInfoSource实现, 默认true
///
/// -- 暂不支持开关UseCase
///
/// 这是一个开放型的模块, 如果你希望构建一个只对外部提供UseCase的模块,
/// 则请注意将内部注册的模块添加特定的用例名
class UserPackage extends IGetArchPackage {
  final bool openIUserRepo;
  final bool openIUserLocalSource;
  final bool openIUserAPI;
  final bool openIEnvInfoSource;
  UserPackage({
    EnvConfig pkgEnv,
    this.openIUserAPI: false,
    this.openIUserLocalSource: true,
    this.openIUserRepo: true,
    this.openIEnvInfoSource: true,
  }) : super(pkgEnv);

  @override
  Future<void> init(EnvConfig env, bool printConfig) async {
    // 在这里加载本模块默认的基础设施实现
    if (openIEnvInfoSource) await EnvInfoPackage().init(env, printConfig);
    return await super.init(env, printConfig);
  }

  // 本模块还没有需要init的内容
  @override
  Future<void> initPackage(EnvConfig config) => null;

  @override
  Future<void> initPackageDI(EnvConfig config) async {
    if (openIUserLocalSource)
      _g.registerLazySingleton<IUserLocalSource>(
          () => UserLocalSource(_g<IStorage>()));

    if (openIUserAPI)
      _g.registerLazySingleton<IUserAPI>(() => UserAPI(_g<IHttp>()));

    if (openIUserRepo)
      _g.registerLazySingleton<IUserRepo>(() => UserRepoImpl(
            _g<IUserLocalSource>(),
            _g<IUserAPI>(),
            _g<IEnvInfoSource>(),
          ));

    // 用例注册
    await initDI(config.envSign);
  }

  @override
  Map<String, bool> get printBoolStateWithRegTypeName => {
        'IUserAPI': openIUserAPI,
        'IUserRepo': openIUserRepo,
        'IEnvInfoSource': openIEnvInfoSource,
        'IUserLocalSource': openIUserLocalSource,
      };
  @override
  Map<String, String> printOtherStateWithEnvConfig(EnvConfig config) => null;
}

/// 在这里可以使用injectable自动生成DI代码,
/// 直接将生成的代码复制到initPackageDI()中, 便于手动控制注册情况
@injectableInit
Future<void> initDI(EnvSign env) async {
  $initGetIt(_g, environment: env.toString());
}
