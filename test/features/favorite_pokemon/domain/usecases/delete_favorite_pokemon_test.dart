import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/features/favorite_pokemon/domain/repositories/favorite_pokemon_repository.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/delete_favorite_pokemon.dart';

@GenerateNiceMocks([MockSpec<FavoritePokemonRepository>()])
import 'delete_favorite_pokemon_test.mocks.dart';

void main() {
  late DeleteFavoritePokemon deleteFavoritePokemon;
  late MockFavoritePokemonRepository mockFavoritePokemonRepository;
  setUp(() {
    mockFavoritePokemonRepository = MockFavoritePokemonRepository();
    deleteFavoritePokemon =
        DeleteFavoritePokemon(mockFavoritePokemonRepository);
  });
  const input = 123;
  const int expected = 0;
  test('should delete a pokemon by row id', () async {
    when(mockFavoritePokemonRepository.deleteFavoritePokemon(any))
        .thenAnswer((_) async => const Right(expected));
    final result = await deleteFavoritePokemon(input);
    expect(result, const Right(expected));
    verify(mockFavoritePokemonRepository.deleteFavoritePokemon(input));
    verifyNoMoreInteractions(mockFavoritePokemonRepository);
  });
}
