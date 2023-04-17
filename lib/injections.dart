import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/features/pokemon_search/data/datasources/pokemon_search_remote_data_source.dart';
import 'package:poke_app/features/pokemon_search/data/repositories/pokemon_search_repositoty_impl.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon_by_id.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon_by_name.dart';
import 'package:poke_app/features/pokemon_search/presentation/bloc/pokemon_search_bloc.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/pokemon_search/domain/repositories/pokemon_search_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => PokemonSearchBloc(
      getPokemonById: sl(), getPokemonByName: sl(), inputConverter: sl()));
  sl.registerLazySingleton(() => GetPokemonById(sl()));
  sl.registerLazySingleton(() => GetPokemonByName(sl()));
  sl.registerLazySingleton<PokemonSearchRepository>(() =>
      PokemonSearchRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => InputConverter());

  sl.registerLazySingleton<PokemonSearchRemoteDataSource>(
      () => PokemonSearchRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
