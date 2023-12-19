import 'package:floor/floor.dart';
import 'package:terceira_prova/domain/pokemon.dart';

@dao
abstract class PokemonDAO {
  @insert
  Future<void> insertPokemon(Pokemon p);

  @Query('SELECT * FROM app_database')
  Future<List<Pokemon>> listAll();

  @Query('SELECT * FROM app_database where id = :id')
  Future<List<Pokemon?>> findById(int id);

  @Query('DELETE FROM app_database where id = :id')
  Future<void> deletePokemon(int id);
}
