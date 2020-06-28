// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:ga_user/infrastructure/user_local_source.dart';
import 'package:ga_user/interface/i_user_source.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:ga_user/infrastructure/user_api_impl.dart';
import 'package:ga_user/interface/i_user_api.dart';
import 'package:ga_user/interface/user_repo_impl.dart';
import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:gat_env_info/interface/i_env_info_source.dart';
import 'package:ga_user/application/update.dart';
import 'package:ga_user/application/login.dart';
import 'package:ga_user/application/register.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<IUserLocalSource>(
      () => UserLocalSource(g<IStorage>()));
  g.registerLazySingleton<IUserAPI>(() => UserAPI(g<IHttp>()));
  g.registerLazySingleton<IUserRepo>(() => UserRepoImpl(
        g<IUserLocalSource>(),
        g<IUserAPI>(),
        g<IEnvInfoSource>(),
      ));
  g.registerLazySingleton<UpdateUserInfo>(() => UpdateUserInfo());
  g.registerLazySingleton<UserLogin>(() => UserLogin(g<IUserRepo>()));
  g.registerLazySingleton<UserRegister>(() => UserRegister(g<IUserRepo>()));
}
