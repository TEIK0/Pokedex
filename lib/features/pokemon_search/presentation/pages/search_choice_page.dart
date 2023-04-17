import 'package:flutter/material.dart';
import 'package:poke_app/features/pokemon_search/presentation/pages/search_result_page.dart';

class SearchChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: searchChoiceBody(context),
    );
  }

  Center searchChoiceBody(BuildContext context) {
    late String input;
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Buscar pokemon por',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.red,
          width: 300,
          child: TextField(
            cursorColor: Colors.black,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: '  Nombre',
            ),
            style: const TextStyle(
                backgroundColor: Colors.red, color: Colors.black, fontSize: 30),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
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
                backgroundColor: Colors.red, color: Colors.black, fontSize: 30),
          ),
        ),
      ]),
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
}
