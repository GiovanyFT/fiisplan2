import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Para garantir apenas uma instância (Singleton) de DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();

  // Esse é um named contructor (que chama o construtor padrão alocando o objeto)
  DatabaseHelper.getInstance();

  // Se o usuário usar DatabaseHelper() é a mesma coisa de fazer DatabaseHelper.getInstance()
  factory DatabaseHelper() => _instance;

  static Database? _db = null;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'fundos.db');
    print("Database path ==> $path");

    var db = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE USUARIO (id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, nome	TEXT, tipo	TEXT,'
        'login TEXT, senha TEXT, endereco TEXT, urlFoto TEXT)');
    await db.execute(
        'CREATE TABLE FUNDO_IMOBILIARIO (id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, sigla	TEXT, nome	TEXT, segmento	TEXT)');
    await db.execute(
        'CREATE TABLE PATRIMONIO (id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, valor_medio	REAL, qt_cotas	INTEGER, '
        ' id_fundo INTEGER,'
        ' id_usuario INTEGER,'
        'FOREIGN KEY(id_fundo) REFERENCES FUNDO_IMOBILIARIO(id),'
        'FOREIGN KEY(id_usuario) REFERENCES USUARIO(id))');
    await db.execute(
        'CREATE TABLE COMPRA (id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, data_transacao	TEXT, valor_cota REAL, '
        'quantidade INTEGER, taxa REAL, '
        'id_patrimonio INTEGER,'
        'FOREIGN KEY(id_patrimonio) REFERENCES PATRIMONIO(id))');
    await db.execute(
        'CREATE TABLE VENDA (id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, data_transacao	TEXT, valor_cota REAL, '
        'quantidade INTEGER, taxa REAL, '
        'id_patrimonio INTEGER,'
        'FOREIGN KEY(id_patrimonio) REFERENCES PATRIMONIO(id))');
    await db.execute(
        'CREATE TABLE DIVIDENDO (id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, data	TEXT, valor REAL, '
        'id_patrimonio INTEGER,'
        'FOREIGN KEY(id_patrimonio) REFERENCES PATRIMONIO(id))');

    await db.transaction((txn) async {
      int id2 = await txn.rawInsert(
          'INSERT INTO USUARIO(nome, tipo, login, senha, urlFoto, endereco) '
          'VALUES("Teste", "Padrão", "teste@gmail.com", "123", null, "Rua Teste")');
      print('inserted1: $id2');

      int id3 = await txn.rawInsert(
          'INSERT INTO USUARIO(nome, tipo, login, senha, urlFoto, endereco) '
          'VALUES("Administrador", "Administrador", "admin", "admin", null, "Rua Pedro Epichin, 351, Colatina Velha, Colatina, ES")');
      print('inserted1: $id3');
    });

    if (version >= 2) {
      await db.execute("alter table VENDA add valor_medio_compra REAL");
    }
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (newVersion < 2) {
      await db.execute("alter table VENDA add valor_medio_compra REAL");
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
