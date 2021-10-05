
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/transacao.dart';
import 'package:fiisplan2/util/formatacao.dart';

import 'base_dao.dart';

abstract class TransacaoDAO<T extends Transacao> extends BaseDAO<T>{

  Future<List<T>> obterLista(Patrimonio patrimonio) async{
    List<T> transacoes = await this.obterListaBase(
        nomes_filtros : ["id_patrimonio"],
        valores : [patrimonio.id]);
    for(T transacao in transacoes){
      transacao.patrimonio = patrimonio;
    }
    return transacoes;
  }

  void excluir(T transacao) async{
    print(transacao.toString());
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      Patrimonio patrimonio = transacao.patrimonio;
      int id1 = await txn.rawUpdate('UPDATE PATRIMONIO SET '
          ' valor_medio = ?, qt_cotas = ? WHERE id = ?',
          [ patrimonio.valor_medio, patrimonio.qt_cotas, patrimonio.id]);
      print('updated1: $id1');

      int id2 = await txn.rawDelete(
          'delete from $nomeTabela where id = ?', [transacao.id]);
      print('deleted2: $id2');
    });
  }

  void inserir(T transacao) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      Patrimonio patrimonio = transacao.patrimonio;
      int id1 = await txn.rawUpdate('UPDATE PATRIMONIO SET '
          ' valor_medio = ?, qt_cotas = ? WHERE id = ?',
          [ patrimonio.valor_medio, patrimonio.qt_cotas, patrimonio.id]);
      print('updated1: $id1');

      int id2 = await txn.rawInsert(
          'INSERT INTO $nomeTabela (data_transacao, valor_cota, quantidade, taxa, id_patrimonio) '
              'VALUES(?, ?, ?, ?, ? )',
          [formatarDateTime(transacao.data_transacao), transacao.valor_cota, transacao.quantidade, transacao.taxa,
            transacao.patrimonio.id]);
      print('inserted2: $id2');
    });
  }

  Future<int?> obterQuantidade(Patrimonio patrimonio) async{
    return await obterQuantidadeBase(
        nomes_filtros : ["id_patrimonio"],
        valores : [patrimonio.id]
    );
  }
}