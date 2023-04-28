import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/features/favorite_pokemon/data/repositories/favorite_pokemon_repository_impl.dart';
import 'package:poke_app/features/favorite_pokemon/domain/repositories/favorite_pokemon_repository.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/get_favorite_pokemon.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/show_favorite_pokemon_list.dart';
import 'package:poke_app/features/favorite_pokemon/presentation/bloc/favorites_bloc.dart';
import 'package:poke_app/features/pokemon_search/data/datasources/pokemon_search_remote_data_source.dart';
import 'package:poke_app/features/pokemon_search/data/repositories/pokemon_search_repositoty_impl.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon.dart';
import 'package:poke_app/features/pokemon_search/presentation/bloc/pokemon_search_bloc.dart';

import 'core/database/db_provider.dart';
import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/favorite_pokemon/domain/usecases/delete_favorite_pokemon.dart';
import 'features/pokemon_search/domain/repositories/pokemon_search_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //Register Data Base
  sl.registerLazySingleton(() => DBProvider.db);

  //Register Search Bloc and Favorites Bloc
  sl.registerFactory(() => PokemonSearchBloc(
      getPokemon: sl(), inputConverter: sl(), remoteDataSource: sl()));
  sl.registerFactory(() => FavoritesBloc(repository: sl()));

  //Register Search Feature complements
  sl.registerLazySingleton(() => GetPokemon(sl()));
  sl.registerLazySingleton<PokemonSearchRepository>(() =>
      PokemonSearchRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<PokemonSearchRemoteDataSource>(
      () => PokemonSearchRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton(
      () => PokemonSearchRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //Reguster Favorites Feature complements
  sl.registerLazySingleton(() => GetFavoritePokemon(sl()));
  sl.registerLazySingleton(() => DeleteFavoritePokemon(sl()));
  sl.registerLazySingleton(() => ShowFavoritePokemonList(sl()));
  sl.registerLazySingleton<FavoritePokemonRepository>(
      () => FavoritePokemonRepositoryImpl(db: sl()));
  sl.registerLazySingleton(() => FavoritePokemonRepositoryImpl(db: sl()));
}
