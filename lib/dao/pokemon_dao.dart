import 'package:floor/floor.dart';
import 'package:terceira_prova/domain/pokemon.dart';

@dao
abstract class PokemonDAO {
  @insert
  Future<void> insertPokemon(Pokemon p);

  @Query('SELECT * FROM Pokemon')
  Future<List<Pokemon>> listAll();

  @Query('SELECT * FROM Pokemon where idPokedex = :id')
  Future<List<Pokemon?>> findById(int id);

  @Query('DELETE FROM Pokemon where idPokedex = :id')
  Future<void> deletePokemon(int id);
}
