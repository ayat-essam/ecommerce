import 'package:dio/dio.dart' as _i361;
import 'package:ecommerce/core/di/register_module.dart' as _i709;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:ecommerce/features/auth/data/data_sources/local/auth_local_data_source.dart' as _i395;
import 'package:ecommerce/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart' as _i407;
import 'package:ecommerce/features/auth/data/repositories/auth_repository.dart' as _i177;
import 'package:ecommerce/features/auth/presentation/cubit/auth_cubit.dart' as _i350;

extension GetItInjectableX on _i174.GetIt {
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();

    // Register SharedPreferences instance asynchronously
    await gh.factoryAsync<_i460.SharedPreferences>(
          () => registerModule.getSharedPref(),
      preResolve: true,
    );

    // Register Dio instance as a singleton
    gh.singleton<_i361.Dio>(
        registerModule.dio as _i174.FactoryFunc<_i361.Dio>);

    // Register AuthRemoteDataSource as a singleton
    gh.singleton<_i407.AuthAPIRemoteDataSource>(
            () => _i407.AuthAPIRemoteDataSource(gh<_i361.Dio>()));

    // Register AuthLocalDataSource as a singleton
    gh.singleton<_i395.AuthLocalDataSource>(() =>
        _i395.AuthSharedPrefLocalDataSource(gh<_i460.SharedPreferences>()));

    // Register AuthRepository as a singleton
    gh.singleton<_i177.AuthRepository>(() => _i177.AuthRepository(
      gh<_i407.AuthAPIRemoteDataSource>(),
      gh<_i395.AuthLocalDataSource>(),
    ));

    // Register AuthCubit as a singleton
    gh.singleton<_i350.AuthCubit>(
            () => _i350.AuthCubit(gh<_i177.AuthRepository>()));

    return this;
  }
}

class _$RegisterModule extends _i709.RegisterModule {
  // Initialize and return Dio instance
  _i361.Dio get dio => _i361.Dio();

  // Initialize and return SharedPreferences instance asynchronously
  @preResolve
  Future<_i460.SharedPreferences> getSharedPref() async {
    return await _i460.SharedPreferences.getInstance();
  }
}
