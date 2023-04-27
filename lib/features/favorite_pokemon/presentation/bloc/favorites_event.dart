part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonFromFavoriteList extends FavoritesEvent {
  final int input;

  const GetPokemonFromFavoriteList(this.input);

  @override
  List<Object> get props => [input];
}

class ResetFavorite extends FavoritesEvent {
  const ResetFavorite();

  @override
  List<Object> get props => [];
}

class GetPokemonFavoritesListFromDB extends FavoritesEvent {
  const GetPokemonFavoritesListFromDB();
  @override
  List<Object> get props => [];
}

class DeleteFavoritePokemonFromDB extends FavoritesEvent {
  final int input;

  const DeleteFavoritePokemonFromDB(this.input);

  @override
  List<Object> get props => [input];
}
