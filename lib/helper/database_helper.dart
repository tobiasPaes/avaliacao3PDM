import 'package:terceira_prova/dao/database.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class DatabasePokemonHelper {
  static final DatabasePokemonHelper _instance =
      DatabasePokemonHelper._internal();
  factory DatabasePokemonHelper() => _instance;

  DatabasePokemonHelper._internal();

  Appdatabase? _pokemonDatabase;

  Future<Appdatabase> get pokemonDatabase async {
    _pokemonDatabase ??= await initDatabase();
    return _pokemonDatabase!;
  }

  Future<Appdatabase> initDatabase() async {
    String? databasesPath = await sqflite.getDatabasesPath();
    // String path = join(databasesPath, "pokemon_database.db");

    return $FloorAppdatabase.databaseBuilder("pokemon_database.db").build();
  }

  Future<Pokemon> savePokemon(Pokemon pokemon) async {
    final db = await pokemonDatabase;
    await db.pokeDao.insertPokemon(pokemon);
    return pokemon;
  }

  Future<List<Pokemon>> getAllPokemons() async {
    final db = await pokemonDatabase;
    return db.pokeDao.listAll();
  }

  Future<void> deletePokemon(int id) async {
    final db = await pokemonDatabase;
    await db.pokeDao.deletePokemon(id);
  }
}
