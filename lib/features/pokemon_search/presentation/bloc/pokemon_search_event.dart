part of 'pokemon_search_bloc.dart';

abstract class PokemonSearchEvent extends Equatable {
  const PokemonSearchEvent([numberString]);

  @override
  List<Object> get props => [];
}

class GetSearchedPokemon extends PokemonSearchEvent {
  final String input;

  const GetSearchedPokemon(this.input);

  @override
  List<Object> get props => [input];
}

class Reset extends PokemonSearchEvent {
  const Reset();

  @override
  List<Object> get props => [];
}

class AddFavorite extends PokemonSearchEvent {
  final String input;

  const AddFavorite(this.input);

  @override
  List<Object> get props => [input];
}
