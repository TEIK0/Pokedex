part of 'pokemon_search_bloc.dart';

abstract class PokemonSearchState extends Equatable {
  const PokemonSearchState();

  @override
  List<Object> get props => [];
}

class Empty extends PokemonSearchState {}

class Loading extends PokemonSearchState {}

class Loaded extends PokemonSearchState {
  final Pokemon pokemon;

  const Loaded({required this.pokemon});

  @override
  List<Object> get props => super.props..addAll([pokemon]);
}

class Error extends PokemonSearchState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => super.props..addAll([message]);
}
