import 'package:get_it/get_it.dart';
import 'package:shoes_app/data/datasource/preferences/preferences_helper.dart';
import 'package:shoes_app/data/datasource/remote/auth_remote_data_source.dart';
import 'package:shoes_app/data/datasource/remote/product_remote_data_source.dart';
import 'package:shoes_app/data/datasource/remote/user_remote_data_source.dart';
import 'package:shoes_app/data/repository/auth_repository.dart';
import 'package:shoes_app/data/repository/product_repository.dart';
import 'package:shoes_app/data/repository/user_repository.dart';
import 'package:shoes_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:shoes_app/presentation/cubits/home/home_cubit.dart';
import 'package:shoes_app/presentation/cubits/user/user_cubit.dart';
import 'package:shoes_app/presentation/providers/preferences_provider.dart';
import 'package:shoes_app/utils/helpers/dio_helper.dart';


final locator = GetIt.instance;

void init(){
  locator.registerFactory(
        () => PreferencesProvider(
        PreferencesHelper()
    ),
  );
  locator.registerFactory(
    () => HomeCubit(locator()),
  );
  locator.registerFactory(
        () => UserCubit(locator()),
  );
  locator.registerFactory(
        () => AuthCubit(
        locator(),
    ),
  );

  //repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator()),
  );

  // data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<UserRemoteDataSoruce>(
    () => UserRemoteDataSourceImpl(locator()),
  );

  //helper
  locator.registerLazySingleton(() => DioHelper().getDioClient());
}