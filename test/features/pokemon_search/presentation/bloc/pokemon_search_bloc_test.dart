import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/database/db_provider.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/models/pokemon_model.dart';
import 'package:poke_app/core/util/input_converter.dart';
import 'package:poke_app/features/pokemon_search/data/datasources/pokemon_search_remote_data_source.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon.dart';
import 'package:poke_app/features/pokemon_search/presentation/search_whit_bloc/bloc/pokemon_search_bloc.dart';
import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([
  MockSpec<GetPokemon>(),
  MockSpec<InputConverter>(),
  MockSpec<PokemonSearchRemoteDataSourceImpl>(),
  MockSpec<DBProvider>(),
  MockSpec<http.Client>()
])
import 'pokemon_search_bloc_test.mocks.dart';

void main() {
  late PokemonSearchBloc bloc;
  late MockGetPokemon mockGetPokemon;
  late MockInputConverter mockInputConverter;
  late MockDBProvider mockDBProvider;
  late MockPokemonSearchRemoteDataSourceImpl
      mockPokemonSearchRemoteDataSourceImpl;
  late MockPokemonSearchRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockGetPokemon = MockGetPokemon();
    mockInputConverter = MockInputConverter();
    mockDBProvider = MockDBProvider();
    mockHttpClient = MockClient();
    mockPokemonSearchRemoteDataSourceImpl =
        MockPokemonSearchRemoteDataSourceImpl();
    bloc = PokemonSearchBloc(
        getPokemon: mockGetPokemon,
        inputConverter: mockInputConverter,
        remoteDataSource: mockPokemonSearchRemoteDataSourceImpl);
  });

  test('initial State should be Empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('Get Pokemon By Id', () {
    const tNumberString = '132';
    const tNumberParsed = 132;
    final pokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
    void setUpInputConverterTest() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));

    test(
        'should call the inputConverter to validate and convert the String to an unsigned integer',
        () async {
      setUpInputConverterTest();
      when(mockGetPokemon(any)).thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetSearchedPokemon(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
      final expected = [const Error(message: INVALID_INPUT_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetSearchedPokemon(tNumberString));
    });

    test('should get data from the concrete use case', () async {
      setUpInputConverterTest();
      when(mockGetPokemon(any)).thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetSearchedPokemon(tNumberString));
      await untilCalled(mockGetPokemon(any));
      verify(mockGetPokemon(tNumberString));
    });
    test('Should emit[Loading,Loaded] when data is gotten succesfully',
        () async {
      setUpInputConverterTest();
      when(mockGetPokemon(any)).thenAnswer((_) async => Right(pokemonModel));
      final expected = [Loading(), Loaded(pokemon: pokemonModel)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetSearchedPokemon(tNumberString));
    });
    test('Should emit[Loading,Error] when getting data fails', () async {
      setUpInputConverterTest();
      when(mockGetPokemon(any)).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetSearchedPokemon(tNumberString));
    });
    test(
        'Should emit[Loading,Error] whit proper message for the error when getting data fails',
        () async {
      setUpInputConverterTest();
      when(mockGetPokemon(any)).thenAnswer((_) async => Left(CacheFailure()));
      final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetSearchedPokemon(tNumberString));
    });
  });
  group('Get Pokemon By Name', () {
    const input = 'ditto';
    final pokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));

    test('should get data from the concrete use case', () async {
      when(mockGetPokemon(any)).thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetSearchedPokemon(input));
      await untilCalled(mockGetPokemon(any));
      verify(mockGetPokemon(input));
    });
    test('Should emit[Loading,Loaded] when data is gotten succesfully',
        () async {
      when(mockGetPokemon(any)).thenAnswer((_) async => Right(pokemonModel));
      final expected = [Loading(), Loaded(pokemon: pokemonModel)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetSearchedPokemon(input));
    });
    test('Should emit[Loading,Error] when getting data fails', () async {
      when(mockGetPokemon(any)).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetSearchedPokemon(input));
    });
    test(
        'Should emit[Loading,Error] whit proper message for the error when getting data fails',
        () async {
      when(mockGetPokemon(any)).thenAnswer((_) async => Left(CacheFailure()));
      final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetSearchedPokemon(input));
    });
  });

  group('Add Pokemon To Favorite', () {
    const tNumberString = '132';
    const tNumberParsed = 132;
    final pokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
    void setUpInputConverterTest() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));

    test(
        'should call the inputConverter to validate and convert the String to an unsigned integer',
        () async {
      setUpInputConverterTest();
      when(mockGetPokemon(any)).thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetSearchedPokemon(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should get data from the concrete use case', () async {
      setUpInputConverterTest();
      when(mockGetPokemon(any)).thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetSearchedPokemon(tNumberString));
      await untilCalled(mockGetPokemon(any));
      verify(mockGetPokemon(tNumberString));
    });
    test('should add to favorites', () async {
      final pokemonModel =
          PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
      await mockDBProvider.newPokemon(pokemonModel);
      verify(mockDBProvider.newPokemon(pokemonModel));
    });
  });
}
