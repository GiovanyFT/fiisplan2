
import 'package:fiisplan2/dominio/imposto.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/dominio/venda.dart';
import 'package:fiisplan2/util/meses_ano.dart';

import 'fabrica_contoladora.dart';

class ImpostoControl{

  Future<List<Imposto>> gerarImpostos(String texto_ano, String texto_mes) async {
    List<Imposto> impostos = <Imposto>[];
    Usuario? usuario = await Usuario.obter();
    List patrimonios = await FabricaControladora
        .obterPatrimonioControl().obterPatrimonios(usuario!);
    for (Patrimonio patrimonio in patrimonios) {
      List vendas = await FabricaControladora.obterVendaControl()
          .obterVendas(patrimonio, texto_ano);
      List<Venda> vendas_a_tributar = <Venda>[];
      for (Venda venda in vendas) {
        int mes = venda.data_transacao.month;
        String mes_string = MesesAno.meses[mes - 1];
        if (mes_string == texto_mes) {
          vendas_a_tributar.add(venda);
        }
      }

      if (vendas_a_tributar.length > 0) {
        impostos.add(Imposto(vendas_a_tributar));
      }
    }
    return impostos;
  }
}