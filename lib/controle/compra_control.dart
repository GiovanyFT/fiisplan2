
import 'package:fiisplan2/dominio/compra.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/persistencia/compra_dao.dart';

Comparator<Compra> compraPorData = (c1, c2) => c1.data_transacao.compareTo(c2.data_transacao);

class CompraControl{
  CompraDAO _dao = CompraDAO();

  Future<List<Compra>> obterCompras(Patrimonio patrimonio, String texto_ano) async{
    List<Compra> compras = await _dao.obterLista(patrimonio);
    List<Compra> compras_ano = <Compra>[];
    for(Compra compra in compras){
      int ano = compra.data_transacao.year;
      if(ano == int.parse(texto_ano)){
        compras_ano.add(compra);
      }
    }
    compras_ano.sort(compraPorData);
    return compras_ano;
  }


  void inserirCompra(Compra compra){
    Patrimonio patrimonio = compra.patrimonio;
    int nova_quantidade_cotas = patrimonio.qt_cotas + compra.quantidade;
    double novo_total_gasto = (patrimonio.qt_cotas * patrimonio.valor_medio) +
        (compra.quantidade * compra.valor_cota) + compra.taxa;
    patrimonio.valor_medio = novo_total_gasto / nova_quantidade_cotas;
    patrimonio.qt_cotas = nova_quantidade_cotas;

    _dao.inserir(compra);
  }

  void removerCompra(Compra compra) {
    Patrimonio patrimonio = compra.patrimonio;
    int nova_quantidade_cotas = patrimonio.qt_cotas - compra.quantidade;
    double novo_total_gasto = (patrimonio.qt_cotas * patrimonio.valor_medio) -
        (compra.quantidade * compra.valor_cota) - compra.taxa;
    if (nova_quantidade_cotas == 0){
      patrimonio.valor_medio = 0.0;
      patrimonio.qt_cotas = 0;
    } else {
      patrimonio.valor_medio = novo_total_gasto / nova_quantidade_cotas;
      patrimonio.qt_cotas = nova_quantidade_cotas;
    }
    _dao.excluir(compra);
  }

  Future<int?> obterQuantidadeCompras(Patrimonio patrimonio) async{
    return await _dao.obterQuantidade(patrimonio);
  }
}