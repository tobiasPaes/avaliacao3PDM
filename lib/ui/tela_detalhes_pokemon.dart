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
  late List<Pokemon?> list;
  late Pokemon p;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;

    var banco = () async {
      final db = await _db.pokemonDatabase;
      list = await db.pokeDao.findById(id);
      setState(() {
        list;

      });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: Future.value(list),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index]!.nome),

                    );
                  },
                );
              }
            ),
            // Image(image: null),
            Text(list.toString()),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
          ],
        ),
      ),
    );
  }
}
