import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/helper/database_helper.dart';
import 'package:terceira_prova/ui/tela_detalhes_pokemon.dart';

class TelaPokemonCapturado extends StatefulWidget {
  const TelaPokemonCapturado({Key? key});

  @override
  State<TelaPokemonCapturado> createState() => _TelaPokemonCapturadoState();
}

class _TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  List<Pokemon> bolsa = [];
  final DatabasePokemonHelper _databasePokemonHelper = DatabasePokemonHelper();

  @override
  void initState() {
    super.initState();
    _atualizarBolsa();
  }

  Future<void> _atualizarBolsa() async {
    final db = await _databasePokemonHelper.pokemonDatabase;
    final novaBolsa = await db.pokeDao.listAll();
    setState(() {
      bolsa = novaBolsa;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bolsa.isEmpty
          ? const Center(child: Text('Nenhum Pokémon capturado'))
          : ListView.builder(
              itemCount: bolsa.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bolsa[index].nome),
                  onTap: () async {
                    // Detalhes do Pokémon
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhesPokemon(
                          id: bolsa[index].idPokedex,
                        ),
                      ),
                    );
                    // Atualizar a lista ao voltar
                    _atualizarBolsa();
                  },
                  onLongPress: () {
                    // Lógica para soltar o Pokémon
                  },
                );
              },
            ),
    );
  }
}
