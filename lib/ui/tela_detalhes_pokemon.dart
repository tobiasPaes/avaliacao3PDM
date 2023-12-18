// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/database.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/helper/database_helper.dart';

class TelaDetalhesPokemon extends StatefulWidget {
  const TelaDetalhesPokemon({super.key, required this.id});

  final int id;

  @override
  State<TelaDetalhesPokemon> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TelaDetalhesPokemon> {
  DatabasePokemonHelper _db = DatabasePokemonHelper();
  int id = 0;
  List<Pokemon?> list = [];

  @override
  void initState() {
    super.initState();
    id = widget.id;

    var banco = () async {
      final db = await _db.pokemonDatabase;
      list = await db.pokeDao.findById(id);
      setState(() {});
    };

    banco();
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
                        child: ListTile(
                          title: Text(
                            pokemon.nome,
                            style: TextStyle(
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
