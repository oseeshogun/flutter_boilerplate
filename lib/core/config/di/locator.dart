import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/data/remote/dio_client.dart';
import 'package:flutter_boilerplate/core/router/router.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'locator.config.dart';

final locator = GetIt.instance;

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @singleton
  GoRouter router() => AppRouter.router();

  @singleton
  Dio get dio => DioClient.create();
}

@InjectableInit()
void configureDependencies() => locator.init();
