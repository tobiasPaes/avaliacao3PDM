// ignore_for_file: prefer_function_declarations_over_variables, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:terceira_prova/helper/database_helper.dart';
import 'package:terceira_prova/domain/pokemon.dart';

class TelaSoltarPokemon extends StatefulWidget {
  const TelaSoltarPokemon({super.key, required this.id});

  final int id;

  @override
  State<TelaSoltarPokemon> createState() => _TelaSoltarPokemonState();
}

class _TelaSoltarPokemonState extends State<TelaSoltarPokemon> {
  final DatabasePokemonHelper _db = DatabasePokemonHelper();
  int id = 0;
  String imagem = '';
  List<Pokemon?> list = [];

  @override
  void initState() {
    super.initState();
    id = widget.id;
    imagem =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    carregarDados();
  }

  Future<void> carregarDados() async {
    final db = await _db.pokemonDatabase;
    final result = await db.pokeDao.findById(id);
    setState(() {
      list = result;
    });
  }

  Future<void> deletar(int id_pokemon) async {
    final db = await _db.pokemonDatabase;
    await db.pokeDao.deletePokemon(id_pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Pokemon'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  imagem,
                  width: 96,
                  height: 96,
                ),
                Text(list.isNotEmpty ? list.first!.nome : ''),
              ],
            ),
            Text('Tipo: ${list.isNotEmpty ? list.first!.tipos : ''}'),
            Text('Altura: ${list.isNotEmpty ? list.first!.altura : ''}'),
            Text('Peso: ${list.isNotEmpty ? list.first!.peso : ''}'),
            Container(
              height: 80,
            ),
            TextButton(
                onPressed: () {
                  deletar(id);
                  carregarDados();
                  Navigator.pop(context);
                },
                child: const Text('Soltar')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar')),
          ],
        ),
      ),
    );
  }
}
