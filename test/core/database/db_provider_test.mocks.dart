// Mocks generated by Mockito 5.4.0 from annotations
// in poke_app/test/core/database/db_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:poke_app/core/database/db_provider.dart' as _i3;
import 'package:poke_app/core/entities/pokemon.dart' as _i6;
import 'package:poke_app/core/models/core_models.dart' as _i5;
import 'package:sqflite/sqflite.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDatabase_0 extends _i1.SmartFake implements _i2.Database {
  _FakeDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DBProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockDBProvider extends _i1.Mock implements _i3.DBProvider {
  MockDBProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Database> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i4.Future<_i2.Database>.value(_FakeDatabase_0(
          this,
          Invocation.getter(#database),
        )),
      ) as _i4.Future<_i2.Database>);
  @override
  _i4.Future<_i2.Database> initDB() => (super.noSuchMethod(
        Invocation.method(
          #initDB,
          [],
        ),
        returnValue: _i4.Future<_i2.Database>.value(_FakeDatabase_0(
          this,
          Invocation.method(
            #initDB,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Database>);
  @override
  _i4.Future<int> newPokemon(_i5.PokemonModel? pokemon) => (super.noSuchMethod(
        Invocation.method(
          #newPokemon,
          [pokemon],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<_i5.PokemonModel?> getPokemonByRowId(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemonByRowId,
          [id],
        ),
        returnValue: _i4.Future<_i5.PokemonModel?>.value(),
      ) as _i4.Future<_i5.PokemonModel?>);
  @override
  _i4.Future<_i6.Pokemon?> getPokemonByPokemonId(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemonByPokemonId,
          [id],
        ),
        returnValue: _i4.Future<_i6.Pokemon?>.value(),
      ) as _i4.Future<_i6.Pokemon?>);
  @override
  _i4.Future<int> deletePokemon(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deletePokemon,
          [id],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<int> deleteAllPokemons() => (super.noSuchMethod(
        Invocation.method(
          #deleteAllPokemons,
          [],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
}
