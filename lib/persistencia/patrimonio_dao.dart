import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class PatrimonioDAO extends BaseDAO<Patrimonio>{
  @override
  String get nomeTabela => "PATRIMONIO";

  @override
  Patrimonio fromMap(Map<String, dynamic> map) {
    return Patrimonio.fromMap(map);
  }

  Future<List<Patrimonio>> obterLista(Usuario usuario) async{
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $nomeTabela join FUNDO_IMOBILIARIO '
        ' on PATRIMONIO.id_fundo = FUNDO_IMOBILIARIO.id'
        ' where PATRIMONIO.id_usuario = ? ',[usuario.id]);

    final List<Patrimonio> patrimonios = list.map<Patrimonio>((json) => fromMap(json)).toList();

    for(Patrimonio patrimonio in patrimonios){
      patrimonio.usuario = usuario;
    }

    return patrimonios;
  }

  void incluir(Patrimonio patrimonio) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      String sigla = patrimonio.fundo.sigla;
      String nome = patrimonio.fundo.nome;
      String segmento = patrimonio.fundo.segmento;
      int id_fundo = await txn.rawInsert(
          'INSERT INTO FUNDO_IMOBILIARIO(sigla, nome, segmento) VALUES(?, ?, ?)',
          [sigla, nome, segmento]);

      await txn.rawInsert(
          'INSERT INTO $nomeTabela(valor_medio, qt_cotas, id_fundo, id_usuario) '
              'VALUES(?, ?, ?, ?)',
           [ patrimonio.valor_medio, patrimonio.qt_cotas, id_fundo, patrimonio.usuario.id]);
    });
  }

  Future<int?> remover(Patrimonio patrimonio) async {
    print(patrimonio.toString());
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      await txn.rawDelete('delete from $nomeTabela where id = ?', [patrimonio.id]);
      return await txn.rawDelete('delete from FUNDO_IMOBILIARIO where id = ?', [patrimonio.fundo.id]);
    });
  }

  Future<int?> obterQuantidade(Usuario usuario) async{
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $nomeTabela where id_usuario = ${usuario.id}');
    return Sqflite.firstIntValue(list);
  }

}