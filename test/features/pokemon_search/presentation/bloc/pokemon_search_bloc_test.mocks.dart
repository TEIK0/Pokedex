// Mocks generated by Mockito 5.4.0 from annotations
// in poke_app/test/features/pokemon_search/presentation/bloc/pokemon_search_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i14;
import 'dart:typed_data' as _i15;

import 'package:dartz/dartz.dart' as _i3;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:poke_app/core/database/db_provider.dart' as _i13;
import 'package:poke_app/core/entities/pokemon.dart' as _i9;
import 'package:poke_app/core/error/failure.dart' as _i8;
import 'package:poke_app/core/models/core_models.dart' as _i12;
import 'package:poke_app/core/util/input_converter.dart' as _i10;
import 'package:poke_app/features/pokemon_search/data/datasources/pokemon_search_remote_data_source.dart'
    as _i11;
import 'package:poke_app/features/pokemon_search/domain/repositories/pokemon_search_repository.dart'
    as _i2;
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon.dart'
    as _i6;
import 'package:sqflite/sqflite.dart' as _i5;

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

class _FakePokemonSearchRepository_0 extends _i1.SmartFake
    implements _i2.PokemonSearchRepository {
  _FakePokemonSearchRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClient_2 extends _i1.SmartFake implements _i4.Client {
  _FakeClient_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDatabase_3 extends _i1.SmartFake implements _i5.Database {
  _FakeDatabase_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_4 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_5 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetPokemon].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPokemon extends _i1.Mock implements _i6.GetPokemon {
  @override
  _i2.PokemonSearchRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakePokemonSearchRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakePokemonSearchRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.PokemonSearchRepository);
  @override
  _i7.Future<_i3.Either<_i8.Failure, _i9.Pokemon>> call(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [name],
        ),
        returnValue: _i7.Future<_i3.Either<_i8.Failure, _i9.Pokemon>>.value(
            _FakeEither_1<_i8.Failure, _i9.Pokemon>(
          this,
          Invocation.method(
            #call,
            [name],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, _i9.Pokemon>>.value(
                _FakeEither_1<_i8.Failure, _i9.Pokemon>(
          this,
          Invocation.method(
            #call,
            [name],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, _i9.Pokemon>>);
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i10.InputConverter {
  @override
  _i3.Either<_i8.Failure, int> stringToUnsignedInteger(String? str) =>
      (super.noSuchMethod(
        Invocation.method(
          #stringToUnsignedInteger,
          [str],
        ),
        returnValue: _FakeEither_1<_i8.Failure, int>(
          this,
          Invocation.method(
            #stringToUnsignedInteger,
            [str],
          ),
        ),
        returnValueForMissingStub: _FakeEither_1<_i8.Failure, int>(
          this,
          Invocation.method(
            #stringToUnsignedInteger,
            [str],
          ),
        ),
      ) as _i3.Either<_i8.Failure, int>);
}

/// A class which mocks [PokemonSearchRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonSearchRemoteDataSourceImpl extends _i1.Mock
    implements _i11.PokemonSearchRemoteDataSourceImpl {
  @override
  _i4.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_2(
          this,
          Invocation.getter(#client),
        ),
        returnValueForMissingStub: _FakeClient_2(
          this,
          Invocation.getter(#client),
        ),
      ) as _i4.Client);
  @override
  _i7.Future<_i3.Either<_i8.Failure, _i12.PokemonModel>> getPokemon(
          String? pokemon) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemon,
          [pokemon],
        ),
        returnValue:
            _i7.Future<_i3.Either<_i8.Failure, _i12.PokemonModel>>.value(
                _FakeEither_1<_i8.Failure, _i12.PokemonModel>(
          this,
          Invocation.method(
            #getPokemon,
            [pokemon],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, _i12.PokemonModel>>.value(
                _FakeEither_1<_i8.Failure, _i12.PokemonModel>(
          this,
          Invocation.method(
            #getPokemon,
            [pokemon],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, _i12.PokemonModel>>);
}

/// A class which mocks [DBProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockDBProvider extends _i1.Mock implements _i13.DBProvider {
  @override
  _i7.Future<_i5.Database> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i7.Future<_i5.Database>.value(_FakeDatabase_3(
          this,
          Invocation.getter(#database),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Database>.value(_FakeDatabase_3(
          this,
          Invocation.getter(#database),
        )),
      ) as _i7.Future<_i5.Database>);
  @override
  _i7.Future<_i5.Database> initDB() => (super.noSuchMethod(
        Invocation.method(
          #initDB,
          [],
        ),
        returnValue: _i7.Future<_i5.Database>.value(_FakeDatabase_3(
          this,
          Invocation.method(
            #initDB,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Database>.value(_FakeDatabase_3(
          this,
          Invocation.method(
            #initDB,
            [],
          ),
        )),
      ) as _i7.Future<_i5.Database>);
  @override
  _i7.Future<int> newPokemon(_i12.PokemonModel? pokemon) => (super.noSuchMethod(
        Invocation.method(
          #newPokemon,
          [pokemon],
        ),
        returnValue: _i7.Future<int>.value(0),
        returnValueForMissingStub: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<_i12.PokemonModel?> getPokemonByRowId(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemonByRowId,
          [id],
        ),
        returnValue: _i7.Future<_i12.PokemonModel?>.value(),
        returnValueForMissingStub: _i7.Future<_i12.PokemonModel?>.value(),
      ) as _i7.Future<_i12.PokemonModel?>);
  @override
  _i7.Future<_i9.Pokemon?> getPokemonByPokemonId(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemonByPokemonId,
          [id],
        ),
        returnValue: _i7.Future<_i9.Pokemon?>.value(),
        returnValueForMissingStub: _i7.Future<_i9.Pokemon?>.value(),
      ) as _i7.Future<_i9.Pokemon?>);
  @override
  _i7.Future<int> deletePokemon(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deletePokemon,
          [id],
        ),
        returnValue: _i7.Future<int>.value(0),
        returnValueForMissingStub: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<int> deleteAllPokemons() => (super.noSuchMethod(
        Invocation.method(
          #deleteAllPokemons,
          [],
        ),
        returnValue: _i7.Future<int>.value(0),
        returnValueForMissingStub: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i4.Client {
  @override
  _i7.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i14.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i14.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i14.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i14.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);
  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(''),
        returnValueForMissingStub: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<_i15.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i15.Uint8List>.value(_i15.Uint8List(0)),
        returnValueForMissingStub:
            _i7.Future<_i15.Uint8List>.value(_i15.Uint8List(0)),
      ) as _i7.Future<_i15.Uint8List>);
  @override
  _i7.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_5(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_5(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
