import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pokemon_search_event.dart';
part 'pokemon_search_state.dart';

class PokemonSearchBloc extends Bloc<PokemonSearchEvent, PokemonSearchState> {
  PokemonSearchBloc() : super(PokemonSearchInitial()) {
    on<PokemonSearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
