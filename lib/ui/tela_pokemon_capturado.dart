import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/helper/database_helper.dart';
import 'package:terceira_prova/ui/tela_detalhes_pokemon.dart';

class TelaPokemonCapturado extends StatefulWidget {
  const TelaPokemonCapturado({super.key});

  @override
  State<TelaPokemonCapturado> createState() => _TelaPokemonCapturadoState();
}

class _TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  List<Pokemon> bolsa = [];
  // late List<Pokemon> bolsa2;
  final DatabasePokemonHelper _databasePokemonHelper = DatabasePokemonHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    banco();
  }

  void banco() async {
    final db = await _databasePokemonHelper.pokemonDatabase;
    bolsa = await db.pokeDao.listAll();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bolsa.isEmpty
            ? const Text('nenhum pokemon capturado')
            : FutureBuilder(
                future: Future.value(bolsa),
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
                  return ListView.builder(
                    itemCount: bolsa.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(bolsa[index].nome),
                        onTap: () => {
                          //detalhes pokemon
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TelaDetalhesPokemon(id: bolsa[index].idPokedex)))
                        },
                        onLongPress: () => {
                          //soltar pokeon
                        },
                      );
                    },
                  );
                }));
  }
}
