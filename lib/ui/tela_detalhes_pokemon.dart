import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/database.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/helper/database_helper.dart';
import 'package:http/http.dart' as http;

class TelaDetalhesPokemon extends StatefulWidget {
  const TelaDetalhesPokemon({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<TelaDetalhesPokemon> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TelaDetalhesPokemon> {
  final DatabasePokemonHelper _db = DatabasePokemonHelper();
  int id = 0;
  List<Pokemon?> list = [];
  String backgroundImage = "assets/aaaa.jpg";
  String imagem = '';

  @override
  void initState() {
    super.initState();
    id = widget.id;
    imagem =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

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
          await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexao';
      }
      final data = jsonDecode(res.body);

      final urlImage = data['sprites']['front_default'];

      final resImage = await http.get(Uri.parse(urlImage));

      if (resImage.statusCode != HttpStatus.ok) {
        throw 'Erro de conexao';
      }

      final dataImage = jsonDecode(resImage.body);

      imagem = dataImage;
      print(imagem);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Detalhes do Pokémon',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Center(
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
                    ? Container(
                        width: 300,
                        height: 500,
                        child: Card(
                          color: Colors.white.withOpacity(0.7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 96,
                                child: Image.network(
                                  imagem,
                                  width: 96,
                                  height: 96,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text(
                                    pokemon.nome,
                                    style: const TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text('Tipo: ${pokemon.tipos}'),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text('Cor: ${pokemon.cor}'),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text('Altura: ${pokemon.altura}'),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text('Peso: ${pokemon.peso}'),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text('Id: ${pokemon.idPokedex}'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Text('Detalhes não encontrados');
              },
            ),
          ),
        ],
      ),
    );
  }
}
