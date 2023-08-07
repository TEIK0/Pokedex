import 'package:flutter/foundation.dart';

import '../../../../../core/entities/pokemon.dart';
import '../../../domain/usecases/get_pokemon.dart';

class SearchNotifier extends ChangeNotifier {
  final GetPokemon _getPokemon;

  SearchNotifier({
    required GetPokemon getPokemon,
  }) : _getPokemon = getPokemon;

  bool? isLoading = false;
  bool? called = false;
  Pokemon? pokemon;
  String? error;

  Future<void> reset() async {
    called = false;
    error = '';
    notifyListeners();
  }

  Future<void> searchPokemon(String name) async {
    // show loading
    isLoading = true;
    notifyListeners();
    error = '';

    final result = await _getPokemon(name);

    // Handle success or error
    result.fold(
      (e) {
        error = "fail";
        isLoading = false;
      },
      (p) {
        pokemon = p;
        isLoading = false;
        called = true;
      },
    );

    // notify UI
    notifyListeners();
  }
}
