import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/helper/database_helper.dart';
import 'package:terceira_prova/ui/tela_detalhes_pokemon.dart';
import 'package:terceira_prova/ui/tela_soltar_pokemon.dart';

class TelaPokemonCapturado extends StatefulWidget {
  const TelaPokemonCapturado({Key? key});

  @override
  State<TelaPokemonCapturado> createState() => _TelaPokemonCapturadoState();
}

class _TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  List<Pokemon> bolsa = [];
  final DatabasePokemonHelper _databasePokemonHelper = DatabasePokemonHelper();
  String backgroundImage =
      "assets/aaaa.jpg"; // Substitua pelo caminho real da sua imagem

  @override
  void initState() {
    super.initState();
    _atualizarBolsa();
  }

  Future<void> _atualizarBolsa() async {
    if (mounted) {
      final db = await _databasePokemonHelper.pokemonDatabase;
      final novaBolsa = await db.pokeDao.listAll();
      if (mounted) {
        setState(() {
          bolsa = novaBolsa;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // Ajuste a opacidade aqui
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          bolsa.isEmpty
              ? const Center(child: Text('Nenhum Pokémon capturado'))
              : ListView.builder(
                  itemCount: bolsa.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${bolsa[index].idPokedex}.png',
                          width: 48, // Defina o tamanho desejado
                          height: 48,
                        ),
                        title: Text(bolsa[index].nome),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaDetalhesPokemon(
                                id: bolsa[index].idPokedex,
                              ),
                            ),
                          );

                          // Quando retornar da tela de detalhes, atualiza a lista
                          await _atualizarBolsa();
                        },
                        onLongPress: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaSoltarPokemon(
                                id: bolsa[index].idPokedex,
                              ),
                            ),
                          );

                          // Quando retornar da tela de soltar, atualiza a lista
                          await _atualizarBolsa();
                        },
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
