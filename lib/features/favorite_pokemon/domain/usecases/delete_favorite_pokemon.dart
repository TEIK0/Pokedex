import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/favorite_pokemon_repository.dart';

class DeleteFavoritePokemon implements UseCase<int, int> {
  final FavoritePokemonRepository repository;

  DeleteFavoritePokemon(this.repository);

  @override
  Future<Either<Failure, int>> call(int index) async {
    return await repository.deleteFavoritePokemon(index);
  }
}
