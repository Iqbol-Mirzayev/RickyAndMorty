import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ricky_and_morty/core/platform/network_info.dart';
import 'package:ricky_and_morty/future/data/datasources/person_local_data_source.dart';
import 'package:ricky_and_morty/future/data/datasources/person_remote_data_source.dart';
import 'package:ricky_and_morty/future/data/repositories/person_repository_impl.dart';
import 'package:ricky_and_morty/future/domain/usecases/get_all_persons.dart';
import 'package:ricky_and_morty/future/presentation/bloc/person_list_cubit/cubit/person_list_cubit.dart';
import 'package:ricky_and_morty/future/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'future/domain/repositories/person_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init()async  {
  // Bloc / Cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  // Usecase

  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPersons(sl()));

  // Repository

  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSource>(
      () => PersonRemoteDataSourceImpl(client: http.Client()));

  sl.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External

final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() async =>  sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
