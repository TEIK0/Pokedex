part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class Empty extends FavoritesState {}

class Loading extends FavoritesState {}

class LoadedList extends FavoritesState {
  final List<Pokemon> pokemon;

  const LoadedList({required this.pokemon});

  @override
  List<Object> get props => super.props..addAll([pokemon]);
}

class LoadedFavorite extends FavoritesState {
  final Pokemon pokemon;

  const LoadedFavorite({required this.pokemon});

  @override
  List<Object> get props => super.props..addAll([pokemon]);
}

class Error extends FavoritesState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => super.props..addAll([message]);
}
