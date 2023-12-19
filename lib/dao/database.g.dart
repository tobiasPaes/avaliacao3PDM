// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppdatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppdatabaseBuilder databaseBuilder(String name) =>
      _$AppdatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppdatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppdatabaseBuilder(null);
}

class _$AppdatabaseBuilder {
  _$AppdatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppdatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppdatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<Appdatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$Appdatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$Appdatabase extends Appdatabase {
  _$Appdatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PokemonDAO? _pokeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Pokemon` (`nome` TEXT NOT NULL, `tipos` TEXT NOT NULL, `idPokedex` INTEGER NOT NULL, `peso` REAL NOT NULL, `altura` REAL NOT NULL, `cor` TEXT NOT NULL, PRIMARY KEY (`idPokedex`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDAO get pokeDao {
    return _pokeDaoInstance ??= _$PokemonDAO(database, changeListener);
  }
}

class _$PokemonDAO extends PokemonDAO {
  _$PokemonDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pokemonInsertionAdapter = InsertionAdapter(
            database,
            'Pokemon',
            (Pokemon item) => <String, Object?>{
                  'nome': item.nome,
                  'tipos': item.tipos,
                  'idPokedex': item.idPokedex,
                  'peso': item.peso,
                  'altura': item.altura,
                  'cor': item.cor
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Pokemon> _pokemonInsertionAdapter;

  @override
  Future<List<Pokemon>> listAll() async {
    return _queryAdapter.queryList('SELECT * FROM Pokemon',
        mapper: (Map<String, Object?> row) => Pokemon(
            row['nome'] as String,
            row['idPokedex'] as int,
            row['peso'] as double,
            row['altura'] as double,
            row['cor'] as String,
            row['tipos'] as String));
  }

  @override
  Future<List<Pokemon?>> findById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Pokemon where idPokedex = ?1',
        mapper: (Map<String, Object?> row) => Pokemon(
            row['nome'] as String,
            row['idPokedex'] as int,
            row['peso'] as double,
            row['altura'] as double,
            row['cor'] as String,
            row['tipos'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deletePokemon(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM Pokemon where idPokedex = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertPokemon(Pokemon p) async {
    await _pokemonInsertionAdapter.insert(p, OnConflictStrategy.abort);
  }
}
