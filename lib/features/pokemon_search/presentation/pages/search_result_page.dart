import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/features/pokemon_search/presentation/bloc/pokemon_search_bloc.dart';
import 'package:poke_app/injections.dart';
import '../../../../core/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  late String input;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
          child: BlocProvider(
        create: (context) => sl<PokemonSearchBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<PokemonSearchBloc, PokemonSearchState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Buscar pokemon por',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                color: Colors.red,
                                width: 300,
                                child: TextField(
                                  onChanged: (value) {
                                    input = value;
                                  },
                                  onSubmitted: (context) {
                                    dispatchNamedPokemon();
                                  },
                                  cursorColor: Colors.black,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black),
                                    labelText: '  Nombre',
                                  ),
                                  style: const TextStyle(
                                      backgroundColor: Colors.red,
                                      color: Colors.black,
                                      fontSize: 30),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                height: 60,
                              ),
                              Container(
                                color: Colors.red,
                                width: 300,
                                child: const TextField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black),
                                    labelText: '  Numero',
                                  ),
                                  style: TextStyle(
                                      backgroundColor: Colors.red,
                                      color: Colors.black,
                                      fontSize: 30),
                                ),
                              ),
                            ]),
                      );
                    } else if (state is Error) {
                      return MessageDisplay(
                        message: state.message,
                      );
                    } else if (state is Loading) {
                      return LoadingDisplay();
                    } else if (state is Loaded) {
                      return Center(
                        child: Text(state.pokemon.name),
                      );
                    } else {
                      return const Text('Fatal error');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        'Pokedex',
        style: TextStyle(color: Colors.black, fontSize: 40),
      ),
      actions: [
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 50,
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  void dispatchNamedPokemon() {
    controller.clear();
    BlocProvider.of<PokemonSearchBloc>(context).add(GetPokemonForName(input));
  }

  void dispatchNumberedPokemon() {
    controller.clear();
    BlocProvider.of<PokemonSearchBloc>(context).add(GetPokemonForId(input));
  }
}
