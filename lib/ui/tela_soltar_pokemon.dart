// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

    var banco = () async {
      final db = await _db.pokemonDatabase;
      list = await db.pokeDao.findById(id);
    };

    banco();
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
                Image.network(imagem, width: 96, height: 96,),
                Text(list.first!.nome),
              ],
            ),
            Text('Tipo: ${list.first!.tipos}'),
            Text('Altura: ${list.first!.altura}'),
            Text('Peso: ${list.first!.peso}'),
            Container(height: 80,),
            const TextButton(onPressed: null, child: Text('Soltar')),
            const TextButton(onPressed: null, child: Text('Cancelar')),
          ],
        ),
      ),
    );
  }
}
