import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:smartdine_waiter/features/home_page_feature/data/repositories/table_repository_impl.dart';
import 'package:smartdine_waiter/features/home_page_feature/domain/repository/table_repository.dart';
import 'package:smartdine_waiter/features/home_page_feature/domain/use_cases/fetch_all_tables_usecase.dart';
import 'package:smartdine_waiter/features/home_page_feature/presentation/cubit/home_page_cubit.dart';
import 'package:smartdine_waiter/features/order_manage/domain/usecases/update_order_usecase.dart';
import 'package:smartdine_waiter/features/order_manage/presentation/cubit/order_manage_cubit.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/data_sources/restaurant_data_source.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/repositories/restaurant_repository_impl.dart';
import 'package:smartdine_waiter/features/restaurant_home/domain/repositories/restaurant_repository.dart';
import 'package:smartdine_waiter/features/restaurant_home/domain/use_cases/fetch_restaurant_menu_usecase.dart';
import 'package:smartdine_waiter/features/restaurant_home/domain/use_cases/fetch_restaurant_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/data_sources/remote/firebase/common_firestore_datasource.dart';

import 'features/order_manage/data/repositories/orderManageRepositoryImpl.dart';
import 'features/order_manage/domain/repositories/order_manage_repository.dart';
import 'features/order_manage/domain/usecases/add_order_usecase.dart';
import 'features/order_manage/domain/usecases/get_order_list_usecase.dart';

import 'features/restaurant_home/data/data_sources/restaurant_data_source_impl.dart';
import 'features/restaurant_home/presentation/cubit/restaurant_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit

  sl.registerFactory(
    () => HomePageCubit(fetchAllRestaurantUseCase: sl()),
  );

  sl.registerFactory(
    () => RestaurantCubit(
        getRestaurantUseCase: sl(),
        getRestaurantMenuUseCase: sl(),
       ),
  );



  sl.registerFactory<OrderManageCubit>(() => OrderManageCubit(
      addOrderUseCase: sl.call(),
      getOrderListUseCase: sl.call(),
      updateOrderUseCase: sl.call()));

  // Use cases

  sl.registerLazySingleton(
      () => GetRestaurantMenuUseCase(restaurantRepository: sl()));
  sl.registerLazySingleton(
      () => GetRestaurantUseCase(restaurantRepository: sl()));
  sl.registerLazySingleton(() => AddOrderUseCase(orderManageRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateOrderUseCase(orderManageRepository: sl()));
  sl.registerLazySingleton(
      () => GetOrderListUseCase(orderManageRepository: sl()));


  sl.registerLazySingleton<FetchAllTablesUseCase>(
      () => FetchAllTablesUseCase(tableRepository: sl.call()));

  // Repository

  sl.registerLazySingleton<TableRepository>(
      () => TableRepositoryImpl(commonFirestoreDatasource: sl.call()));

  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(restaurantDataSource: sl()),
  );

  sl.registerLazySingleton<OrderManageRepository>(
    () => OrderManageRepositoryImpl(commonFirestoreDatasource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CommonFirestoreDatasource>(
    () => CommonFirestoreDatasource(),
  );

  sl.registerLazySingleton<RestaurantDataSource>(
    () => RestaurantDataSourceImpl(
        auth: sl.call(), fireStore: sl.call(), firebaseStorage: sl.call()),
  );



  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => storage);
}
