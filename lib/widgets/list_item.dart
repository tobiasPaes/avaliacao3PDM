// ignore_for_file: unused_local_variable, unused_field, unused_import
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/database.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/helper/database_helper.dart';
import 'package:terceira_prova/ui/tela_captura.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.id, required this.name});
  final String name;
  final int id;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late Future<Map<String, dynamic>> dadosPokemon;
  final DatabasePokemonHelper _databasePokemonHelper = DatabasePokemonHelper();

  int pokemonId = 0;
  String pokemonName = '';
  String _urlCor = '';
  String pokemonColor = '';

  String erro = '';
  bool naBolsa = false;

  @override
  void initState() {
    super.initState();
    pokemonId = widget.id + 1;
    pokemonName = widget.name;
    dadosPokemon = getDadosPokeApi();
  }

  Future<Map<String, dynamic>> getDadosPokeApi() async {
    try {
      //pegando informacoes gerais do pokemon
      final res = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId'));
      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexao';
      }
      final data = jsonDecode(res.body);
      _urlCor = data['species']['url'];

      //pegando a cor do pokemon
      final cor = await http.get(Uri.parse(_urlCor));
      if (cor.statusCode != HttpStatus.ok) {
        throw 'Erro de conexao';
      }
      final dataColor = jsonDecode(cor.body);
      pokemonColor = dataColor['color']['name'];
      // print(pokemonColor);
      // print(pokemonId);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> capturarPokemon(Pokemon poke) async {
    final db = await _databasePokemonHelper.pokemonDatabase;

    List<Pokemon?> p = await db.pokeDao.findById(poke.idPokedex);

    if (p.isNotEmpty) {
      naBolsa = true;
    } else {
      naBolsa = false;
    }

    try {
      await db.pokeDao.insertPokemon(poke);
    } catch (e) {
      erro = "esse pokemon ja esta na seu pc ou na sua bolsa";
      print(erro);
    }

    // final db =
    //     await $FloorAppdatabase.databaseBuilder('app_database.db').build();
    // final pokeDao = db.pokeDao;
    // List<Pokemon?> pokeBanco = await pokeDao.findById(poke.idPokedex);
    // await pokeDao.insertPokemon(poke);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dadosPokemon,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          final data = snapshot.data!;
          final tipo = data['types'][0]['type']['name'];
          final peso = data['weight'] / 10;
          final altura = data['height'] * 10;
          final cor = pokemonColor;

          return Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$pokemonId, $pokemonName',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
              ),
              Container(
                width: 8.0,
              ),
              IconButton(
                onPressed: !naBolsa
                    ? () {
                        Pokemon p = Pokemon(pokemonName, pokemonId,
                            peso.toDouble(), altura.toDouble(), cor, tipo);
                        capturarPokemon(p);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Pokemon Capturado'),
                          duration: Duration(seconds: 1),
                        ));
                      }
                    : null,
                icon: const Icon(Icons.catching_pokemon),
                color: !naBolsa
                    ? const Color.fromARGB(255, 8, 8, 8)
                    : const Color.fromARGB(255, 233, 38, 38),
              )
            ],
          ));
        });
  }
}
