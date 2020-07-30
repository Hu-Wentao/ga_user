// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/6/26
// Time  : 23:41

import 'package:flutter/cupertino.dart';
import 'package:ga_user/application/get_avatar.dart';
import 'package:ga_user/application/get_user.dart';
import 'package:ga_user/application/user_logout.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:ga_user/infrastructure/user_api_impl.dart';
import 'package:ga_user/infrastructure/user_local_impl.dart';
import 'package:ga_user/interface/i_user_api.dart';
import 'package:ga_user/interface/i_user_local.dart';
import 'package:ga_user/interface/user_date_vm.dart';
import 'package:ga_user/interface/user_repo_impl.dart';
import 'package:get_env_info/interface/i_env_info_source.dart';
import 'package:get_env_info/profile/env_info_package.dart';
import 'package:get_arch_core/domain/env_config.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_arch_quick_start/interface/i_storage.dart';
import 'package:get_arch_quick_start/quick_start.dart';

import '../ga_user.dart';

@protected
GetIt g = GetIt.I;

///
/// 本模块依赖
/// [IHttp] 请确保你的项目已经注册 IHttp
/// ----------------
///
/// [pkgEnv] 建议仅供测试添加, 不赋值时默认使用全局EnvConfig
///
/// 以下bool型变量如果设为false,则表示你需要手动实现并注册对应的接口,
/// 注册接口是不分时间先后的,先加载本模块,然后再加载主项目中自己的实现, 也是没有问题的.
///
/// [openIUserAPI] 用户API实现, 默认false! 请参照源码,实现自己的IUserAPI
///
/// [openIUserRepo] 是否开启IUserRepo, 默认true
/// [openIUserLocal] 本地用户存储实现, 默认true
/// [openIEnvInfo] 是否使用自带的IEnvInfoSource实现, 默认true
///
/// [httpImplName] 用于指定所使用的IHttp的instanceName
///
/// [specProfile] 手动配置用例开关(不建议新手使用)
/// ```dart
///  UserPackage(
///   specProfile: {
///   // 不写即默认开启(true)
///     'UserLogin': false,
///   }
///  ),
///
/// ```
///
/// 这是一个开放型的模块, 如果你希望构建一个只对外部提供UseCase的模块,
/// 则请注意将内部注册的模块添加特定的用例名
class UserPackage extends IGetArchPackage {
  final bool openIUserRepo;
  final bool openIUserLocal;
  final bool openIUserAPI;
  final bool openIEnvInfo;

  final String httpImplName;
  final String storageImplName;

  final Map<Type, bool> specProfile;

  UserPackage({
    EnvConfig pkgEnv,
    this.openIUserAPI: false,
    this.openIUserLocal: true,
    this.openIUserRepo: true,
    this.openIEnvInfo: true,
    this.httpImplName,
    this.storageImplName,
    this.specProfile,
  })  : assert(specProfile != null),
        super(pkgEnv);
  Map<Type, bool> get interfaceImplRegisterStatus => {
        IUserAPI: openIUserAPI,
        IUserRepo: openIUserRepo,
        IEnvInfoSource: openIEnvInfo,
        IUserLocal: openIUserLocal,
      }..addAll(specProfile);
  @override
  Map<String, String> printOtherStateWithEnvConfig(EnvConfig config) => {
        'httpImplName': '$httpImplName',
        'storageImplName': storageImplName,
      };
  @override
  Future<void> init(EnvConfig env, bool printConfig) async {
    // 在这里加载本模块默认的基础设施实现
    if (openIEnvInfo) await EnvInfoPackage().init(env, printConfig);
    return await super.init(env, printConfig);
  }

  // 本模块还没有需要init的内容
  @override
  Future<void> initPackage(EnvConfig config) => null;

  @override
  Future<void> initPackageDI(EnvConfig config) async {
    if (openIUserLocal)
      g.registerLazySingleton<IUserLocal>(
          () => UserLocalImpl(g<IStorage>(instanceName: storageImplName)));

    // 手动配置[instanceName],由于dart无法使用反射,
    // 因此配置instanceName和控制开关,仍需手动编写代码 (可以在自动生成的代码基础上进行修改)
    if (openIUserAPI)
      g.registerLazySingleton<IUserAPI>(
          () => UserAPIImpl(g.get<IHttp>(instanceName: httpImplName)));

    if (openIUserRepo)
      g.registerLazySingleton<IUserRepo>(() => UserRepoImpl(
            g<IUserLocal>(),
            g<IUserAPI>(),
            g<IEnvInfoSource>(),
          ));

    // 用例注册 (均默认开启)
    for (final entry in _specProfileRegisterFunc.entries)
      if (specProfile == null || specProfile[entry.key] ?? true)
        entry.value.call();
  }
}

Map<Type, Function()> get _specProfileRegisterFunc => {
      UserLogin: () =>
          g.registerLazySingleton<UserLogin>(() => UserLogin(g<IUserRepo>())),
      UserRegister: () => g.registerLazySingleton<UserRegister>(
          () => UserRegister(g<IUserRepo>())),
      UserDateVm: () => g.registerLazySingleton<UserDateVm>(() => UserDateVm(
            g<ObsUser>(),
            g<UserUploadAvatarAndUpdate>(),
            g<UserUpdateNickname>(),
            g<UserUpdateSex>(),
            g<GetAvatar>(),
          )),
      UserLogout: () =>
          g.registerLazySingleton<UserLogout>(() => UserLogout(g<IUserRepo>())),
      GetAvatar: () => g.registerLazySingleton<GetAvatar>(
          () => GetAvatar(g<IUserRepo>(), g<GetUser>())),
      ObsUser: () =>
          g.registerLazySingleton<ObsUser>(() => ObsUser(g<IUserRepo>())),
      GetUser: () =>
          g.registerLazySingleton<GetUser>(() => GetUser(g<IUserRepo>())),
      UserUpdateSex: () => g.registerLazySingleton<UserUpdateSex>(
          () => UserUpdateSex(g<IUserRepo>())),
      UserUploadAvatarAndUpdate: () =>
          g.registerLazySingleton<UserUploadAvatarAndUpdate>(
              () => UserUploadAvatarAndUpdate(g<IUserRepo>())),
      UserUpdateNickname: () => g.registerLazySingleton<UserUpdateNickname>(
          () => UserUpdateNickname(g<IUserRepo>())),
    };

///// 在这里可以使用injectable自动生成DI代码,
///// 直接将生成的代码复制到initPackageDI()中, 便于通过配置参数控制依赖注入
//@injectableInit
//Future<void> initDI(EnvSign env) async {
//  $initGetIt(g, environment: env.toString());
//}
