import 'package:flutter/material.dart';
import 'package:terceira_prova/helper/database_helper.dart';
import 'package:terceira_prova/domain/pokemon.dart';

class TelaSoltarPokemon extends StatefulWidget {
  const TelaSoltarPokemon({Key? key, required this.id}) : super(key: key);

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
        backgroundColor: Colors.black,
        title: const Text(
          'Meu Pokémon',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/aaaa.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 400,
            child: Card(
              color: Colors.white.withOpacity(0.7),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        imagem,
                        width: 96,
                        height: 96,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        list.isNotEmpty ? list.first!.nome : '',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('Tipo: ${list.isNotEmpty ? list.first!.tipos : ''}'),
                      Text(
                          'Altura: ${list.isNotEmpty ? list.first!.altura : ''}'),
                      Text('Peso: ${list.isNotEmpty ? list.first!.peso : ''}'),
                      Text('Cor: ${list.isNotEmpty ? list.first!.cor : ''}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          await deletar(id);
                          await carregarDados();
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Soltar'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
