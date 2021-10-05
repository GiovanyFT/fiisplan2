
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/venda.dart';
import 'package:fiisplan2/persistencia/venda_dao.dart';

Comparator<Venda> vendaPorData = (v1, v2) => v1.data_transacao.compareTo(v2.data_transacao);

class VendaControl{
  VendaDAO _dao = VendaDAO();

  Future<List<Venda>> obterVendas(Patrimonio patrimonio, String texto_ano) async {
    List<Venda> vendas = await _dao.obterLista(patrimonio);
    List<Venda> vendas_ano = <Venda>[];
    for(Venda venda in vendas){
      int ano = venda.data_transacao.year;
      if(ano == int.parse(texto_ano)){
        vendas_ano.add(venda);
      }
    }
    vendas_ano.sort(vendaPorData);
    return vendas_ano;
  }

  void inserirVenda(Venda venda){
    Patrimonio patrimonio = venda.patrimonio;

    patrimonio.qt_cotas = patrimonio.qt_cotas - venda.quantidade;
    if (patrimonio.qt_cotas == 0)
      patrimonio.valor_medio = 0.0;

    _dao.inserir(venda);
  }

  void removerVenda(Venda venda) async {
    Patrimonio patrimonio = venda.patrimonio;

    int nova_quantidade_cotas = patrimonio.qt_cotas + venda.quantidade;
    double patrimonio_total_com_venda = patrimonio.qt_cotas * patrimonio.valor_medio;
    double valor_venda_removida = venda.valor_medio_compra * venda.quantidade;

    patrimonio.valor_medio = (patrimonio_total_com_venda + valor_venda_removida)/nova_quantidade_cotas;

    patrimonio.qt_cotas = nova_quantidade_cotas;
    _dao.excluir(venda);
  }

  Future<int?> obterQuantidadeVendas() async{
    return await _dao.obterQuantidadeBase();
  }
}