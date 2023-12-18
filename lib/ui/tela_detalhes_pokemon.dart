// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/database.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/helper/database_helper.dart';
import 'package:http/http.dart' as http;

class TelaDetalhesPokemon extends StatefulWidget {
  const TelaDetalhesPokemon({super.key, required this.id});

  final int id;

  @override
  State<TelaDetalhesPokemon> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TelaDetalhesPokemon> {
  final DatabasePokemonHelper _db = DatabasePokemonHelper();
  int id = 0;
  List<Pokemon?> list = [];

  String imagem = '';


  @override
  void initState() {
    super.initState();
    id = widget.id;

    imagem =
    imagem = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    var banco = () async {
      final db = await _db.pokemonDatabase;
      list = await db.pokeDao.findById(id);
      setState(() {});
    };

    banco();
    getDadosPokeApi();
    print(imagem);
  }

  Future<Map<String, dynamic>> getDadosPokeApi() async {
    try {
      final res =
          await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?$id'));
      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexao';
      }
      final data = jsonDecode(res.body);

      final urlImage = data['results']['sprites']['front_default'];

      final resImage = await http.get(Uri.parse(urlImage));

      if (resImage.statusCode != HttpStatus.ok) {
        throw 'Erro de conexao';
      }

      final dataImage = jsonDecode(resImage.body);

      imagem = dataImage;
      print(imagem);

      // print(data['results']);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes pokemon'),
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.value(list),
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

            final pokemon = list.first;

            return pokemon != null
                ? ListView(
                    children: [
                      Card(
                        child: Image.network(imagem, width: 96, height: 96),

                      ),
                      Card(
                        child: ListTile(
                          title: Text(
                            pokemon.nome,
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Nome: ${pokemon.nome}'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Tipos: ${pokemon.tipos}'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Cor: ${pokemon.cor}'),
                        ),
                      ),

                      // Adicione mais detalhes conforme necessário
                    ],
                  )
                : const Text('Detalhes não encontrados');
          },
        ),
      ),
    );
  }
}
