import 'package:floor/floor.dart';

@entity
class Pokemon {
  // static const String pokemonTable = 'pokemon_table';
  static const String nomeColumn = 'nome';
  static const String tipoColumn = 'tipo';
  static const String pokedexColumn = 'pokedex';
  static const String pesoColumn = 'peso';
  static const String alturaColumn = 'altura';
  static const String corColumn = 'cor';

  String nome = '';
  String tipos = '';
  @primaryKey
  int idPokedex = 0;
  double peso = 0.0; // valor da api/10
  double altura = 0.0; // api vem em decametros
  String cor = ''; // https://pokeapi.co/api/v2/pokemon-species/*pokemon*/

  Pokemon(this.nome, this.idPokedex, this.peso, this.altura, this.cor,
      this.tipos);

  Pokemon.fromMap(Map map) {
    nome = map[nomeColumn];
    tipos = map[tipoColumn];
    idPokedex = map[pokedexColumn];
    peso = map[pesoColumn];
    altura = map[alturaColumn];
    cor = map[corColumn];
  }

  @override
  String toString() {
    return 'Pokemon: idPokemon: $idPokedex, nome: $nome, tipo: $tipos, forte contra: $peso, fraco contra: $altura, numero de evolucoes: $cor';
  }

  Map<String, dynamic> toMap() {
    return {
      nomeColumn: nome,
      tipoColumn: tipos,
      pokedexColumn: idPokedex,
      pesoColumn: peso,
      alturaColumn: altura,
      corColumn: cor,
    };
  }
}
