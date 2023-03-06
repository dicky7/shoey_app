import 'package:get_it/get_it.dart';
import 'package:shoes_app/data/datasource/db/cart_database_helper.dart';
import 'package:shoes_app/data/datasource/db/cart_local_data_source.dart';
import 'package:shoes_app/data/datasource/db/product_local_data_source.dart';
import 'package:shoes_app/data/datasource/remote/transaction_remote_data_source.dart';
import 'package:shoes_app/data/repository/cart_repository.dart';
import 'package:shoes_app/data/repository/transaction_repository.dart';
import 'package:shoes_app/data/repository/wishlist_repository.dart';
import 'package:shoes_app/presentation/providers/auth/auth_providers.dart';
import 'package:shoes_app/presentation/providers/cart/cart_providers.dart';
import 'package:shoes_app/presentation/providers/cart/checkout_providers.dart';
import 'package:shoes_app/presentation/providers/home/detail_product_providers.dart';
import 'package:shoes_app/presentation/providers/home/home_providers.dart';
import 'package:shoes_app/presentation/providers/preferences/preferences_provider.dart';
import 'package:shoes_app/presentation/providers/profile/profile_providers.dart';
import 'package:shoes_app/presentation/providers/transaction/transaction_providers.dart';
import 'package:shoes_app/presentation/providers/wishlist/wishlist_providers.dart';
import 'package:shoes_app/utils/helpers/dio_helper.dart';

import 'data/datasource/db/database_helper.dart';
import 'data/datasource/preferences/preferences_helper.dart';
import 'data/datasource/remote/auth_remote_data_source.dart';
import 'data/datasource/remote/product_remote_data_source.dart';
import 'data/datasource/remote/user_remote_data_source.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/product_repository.dart';
import 'data/repository/user_repository.dart';

final locator = GetIt.instance;

void init(){
  locator.registerFactory(
    () => PreferencesProvider(PreferencesHelper(),
    ),
  );

  locator.registerFactory(
        () => AuthProviders(locator()),
  );
  locator.registerFactory(
    () => HomeProviders(
      locator(),
      locator()
    ),
  );
  locator.registerFactory(
    () => DetailProductProviders(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => CartProviders(locator()),
  );
  locator.registerLazySingleton(
    () => CheckoutProviders(
         locator(),
        locator()),
  );
  locator.registerFactory(
    () => WishlistProviders(locator()),
  );
  locator.registerFactory(
    () => ProfileProviders(locator()),
  );
  locator.registerFactory(
    () => TransactionProviders(locator()),
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
  locator.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(locator()),
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
  locator.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(locator()),
  );

  //helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<CartDatabaseHelper>(() => CartDatabaseHelper());
  locator.registerLazySingleton(() => DioHelper().getDioClient());
 }