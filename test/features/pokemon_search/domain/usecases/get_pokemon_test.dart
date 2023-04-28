import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/models/core_models.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/features/pokemon_search/domain/repositories/pokemon_search_repository.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon.dart';

@GenerateNiceMocks([MockSpec<PokemonSearchRepository>()])
import 'get_pokemon_test.mocks.dart';

void main() {
  late GetPokemon getPokemonByName;
  late MockPokemonSearchRepository mockPokemonSearchRepository;
  setUp(() {
    mockPokemonSearchRepository = MockPokemonSearchRepository();
    getPokemonByName = GetPokemon(mockPokemonSearchRepository);
  });
  const input = 'dito';
  final expectedSprites = SpritesModel(frontDefault: '');
  final List<TypeModel> expectedType = [];
  final List<StatModel> expectedStats = [];
  final expected = Pokemon(
      id: 1,
      name: 'dito',
      sprites: expectedSprites,
      stats: expectedStats,
      types: expectedType);
  test('should get a pokemon by name', () async {
    when(mockPokemonSearchRepository.getPokemon(any))
        .thenAnswer((_) async => Right(expected));
    final result = await getPokemonByName(input);
    expect(result, Right(expected));
    verify(mockPokemonSearchRepository.getPokemon(input));
    verifyNoMoreInteractions(mockPokemonSearchRepository);
  });
}
