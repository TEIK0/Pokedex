import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/models/pokemon_model.dart';
import 'package:poke_app/core/util/input_converter.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon_by_id.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon_by_name.dart';
import 'package:poke_app/features/pokemon_search/presentation/bloc/pokemon_search_bloc.dart';
import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([
  MockSpec<GetPokemonById>(),
  MockSpec<GetPokemonByName>(),
  MockSpec<InputConverter>()
])
import 'pokemon_search_bloc_test.mocks.dart';

void main() {
  late PokemonSearchBloc bloc;
  late MockGetPokemonById mockGetPokemonById;
  late MockGetPokemonByName mockGetPokemonByName;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetPokemonById = MockGetPokemonById();
    mockGetPokemonByName = MockGetPokemonByName();
    mockInputConverter = MockInputConverter();
    bloc = PokemonSearchBloc(
        getPokemonById: mockGetPokemonById,
        getPokemonByName: mockGetPokemonByName,
        inputConverter: mockInputConverter);
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
      when(mockGetPokemonById(any))
          .thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetPokemonForId(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
      final expected = [const Error(message: INVALID_INPUT_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonForId(tNumberString));
    });

    test('should get data from the concrete use case', () async {
      setUpInputConverterTest();
      when(mockGetPokemonById(any))
          .thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetPokemonForId(tNumberString));
      await untilCalled(mockGetPokemonById(any));
      verify(mockGetPokemonById(tNumberParsed));
    });
    test('Should emit[Loading,Loaded] when data is gotten succesfully',
        () async {
      setUpInputConverterTest();
      when(mockGetPokemonById(any))
          .thenAnswer((_) async => Right(pokemonModel));
      final expected = [Loading(), Loaded(pokemon: pokemonModel)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonForId(tNumberString));
    });
    test('Should emit[Loading,Error] when getting data fails', () async {
      setUpInputConverterTest();
      when(mockGetPokemonById(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonForId(tNumberString));
    });
    test(
        'Should emit[Loading,Error] whit proper message for the error when getting data fails',
        () async {
      setUpInputConverterTest();
      when(mockGetPokemonById(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonForId(tNumberString));
    });
  });
  group('Get Pokemon By Name', () {
    const input = 'ditto';
    final pokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));

    test('should get data from the concrete use case', () async {
      when(mockGetPokemonByName(any))
          .thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetPokemonForName(input));
      await untilCalled(mockGetPokemonByName(any));
      verify(mockGetPokemonByName(input));
    });
    test('Should emit[Loading,Loaded] when data is gotten succesfully',
        () async {
      when(mockGetPokemonByName(any))
          .thenAnswer((_) async => Right(pokemonModel));
      final expected = [Loading(), Loaded(pokemon: pokemonModel)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonForName(input));
    });
    test('Should emit[Loading,Error] when getting data fails', () async {
      when(mockGetPokemonByName(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonForName(input));
    });
    test(
        'Should emit[Loading,Error] whit proper message for the error when getting data fails',
        () async {
      when(mockGetPokemonByName(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonForName(input));
    });
  });
}
