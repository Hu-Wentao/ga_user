// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:ga_user/domain/repositories/i_user_repo.dart';
import 'package:ga_user/application/update.dart';
import 'package:ga_user/application/login.dart';
import 'package:ga_user/application/register.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<UpdateUserInfo>(() => UpdateUserInfo());
  g.registerLazySingleton<UserLogin>(() => UserLogin(g<IUserRepo>()));
  g.registerLazySingleton<UserRegister>(() => UserRegister(g<IUserRepo>()));
}
