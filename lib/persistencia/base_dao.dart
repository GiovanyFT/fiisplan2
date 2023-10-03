

import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

abstract class BaseDAO<T>{
  // Vai criar um get abstrato, ou seja, irá forçar os descendentes a atribuí-lo
  String get nomeTabela;

  // Obriga a definir um fromMap para o objeto específico
  T fromMap(Map<String, dynamic> map);

  Future<Database> get db => DatabaseHelper().db;

  Future<int?> obterQuantidadeBase({List<String>? nomes_filtros = null, List? valores = null}) async{
    final dbClient = await db;

    String sql;
    if (nomes_filtros == null){
      sql = 'SELECT count(*) FROM $nomeTabela';
    } else {
      sql = 'SELECT count(*) FROM $nomeTabela WHERE ';
      int qt_filtros = nomes_filtros.length;
      for (int i = 0; i < (qt_filtros - 1); i++) {
        sql += ' ${nomes_filtros[i]} = ? and ';
      }
      sql += ' ${nomes_filtros[qt_filtros - 1]} = ?';
    }
    final list = await dbClient.rawQuery(sql, valores);
    return Sqflite.firstIntValue(list);
  }

  void atualizarBase({required List<String> colunas, required List<String> nomes_filtros, List? valores}) async{
    var dbClient = await db;
    String sql = 'UPDATE $nomeTabela SET ';
    int qt_colunas = colunas.length;
    for(int i=0; i<(qt_colunas-1); i++){
      sql += ' ${colunas[i]} = ?, ';
    }
    sql += ' ${colunas[qt_colunas-1]} = ?';
    sql += ' WHERE ';
    int qt_filtros = nomes_filtros.length;
    for (int i = 0; i < (qt_filtros - 1); i++) {
      sql += ' ${nomes_filtros[i]} = ? and ';
    }
    sql += ' ${nomes_filtros[qt_filtros - 1]} = ?';
    await dbClient.rawUpdate(sql, valores);
  }

  Future<int> inserirBase({List<String>? colunas, List? valores}) async{
    var dbClient = await db;
    String sql = 'INSERT INTO $nomeTabela (';
    int qt_colunas = colunas!.length;
    for(int i=0; i<(qt_colunas-1); i++){
      sql += '${colunas[i]}, ';
    }
    sql += '${colunas[qt_colunas-1]})';
    sql += ' VALUES (';
    for(int i=0; i<(qt_colunas-1); i++){
      sql += '?, ';
    }
    sql += '?)';
    var id = await dbClient.rawInsert(sql, valores);
    return id;
  }

  Future<List<T>>  obterListaBase({List<String>? nomes_filtros = null, List? valores = null}) async {
    String sql;
    if (nomes_filtros == null){
      sql = 'SELECT * FROM $nomeTabela';
    } else {
      sql = 'SELECT * FROM $nomeTabela WHERE ';
      int qt_filtros = nomes_filtros.length;
      for (int i = 0; i < (qt_filtros - 1); i++) {
        sql += ' ${nomes_filtros[i]} = ? and ';
      }
      sql += ' ${nomes_filtros[qt_filtros - 1]} = ?';
    }
    return obterListaQueryBase(sql, valores);
  }

  Future<List<T>>  obterListaQueryBase(String sql, [List<dynamic>? arguments] ) async{
    var dbClient = await db;
    final list = await dbClient.rawQuery(sql, arguments);
    final List<T> list_entity = list.map<T>((map) => fromMap(map)).toList();
    return list_entity;
  }

  Future<int> excluirBase({List<String>? nomes_filtros, List? valores}) async {
    var dbClient = await db;
    String sql = 'DELETE FROM $nomeTabela WHERE ';
    int qt_filtros = nomes_filtros!.length;
    for (int i = 0; i < (qt_filtros - 1); i++) {
      sql += ' ${nomes_filtros[i]} = ? and ';
    }
    sql += ' ${nomes_filtros[qt_filtros - 1]} = ?';
    return await dbClient.rawDelete(sql, valores);
  }

  Future<int> excluirTodosBase() async {
    var dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM $nomeTabela');
  }

}