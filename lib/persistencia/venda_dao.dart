
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/venda.dart';
import 'package:fiisplan2/persistencia/transacao_dao.dart';
import 'package:fiisplan2/util/formatacao.dart';

class VendaDAO extends TransacaoDAO<Venda>{
  @override
  String get nomeTabela => "VENDA";

  @override
  Venda fromMap(Map<String, dynamic> map) {
    return Venda.fromMap(map);
  }

  void inserir(Venda venda) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      Patrimonio patrimonio = venda.patrimonio;
      await txn.rawUpdate('UPDATE PATRIMONIO SET '
          ' valor_medio = ?, qt_cotas = ? WHERE id = ?',
          [ patrimonio.valor_medio, patrimonio.qt_cotas, patrimonio.id]);

      await txn.rawInsert(
          'INSERT INTO $nomeTabela (data_transacao, valor_cota, quantidade, taxa, id_patrimonio, valor_medio_compra) '
              'VALUES(?, ?, ?, ?, ?, ? )',
          [formatarDateTime(venda.data_transacao), venda.valor_cota, venda.quantidade, venda.taxa,
            venda.patrimonio.id, venda.valor_medio_compra]);
    });
  }
}