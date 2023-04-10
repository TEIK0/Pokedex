part of 'pokemon_search_bloc.dart';

abstract class PokemonSearchState extends Equatable {
  const PokemonSearchState();  

  @override
  List<Object> get props => [];
}
class PokemonSearchInitial extends PokemonSearchState {}
