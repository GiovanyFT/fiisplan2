import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/dividendo.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/meses_ano.dart';

class ControleCardSumarizacaoDividendos{
  Patrimonio patrimonio;
  String text_ano;
  late List<double> dividendos_por_mes;
  late double total_ano;

  ControleCardSumarizacaoDividendos(this.patrimonio, this.text_ano);

  Future<List<double>> gerarDividendosPorMes() async{
    List<Dividendo> dividendos = await FabricaControladora.obterDividendoControl().obterDividendos(patrimonio, text_ano);
    dividendos_por_mes = <double>[];
    total_ano = 0;
    for(String mes in MesesAno.meses){
      double valor = 0;
      for(Dividendo dividendo in dividendos){
        if(mes == MesesAno.meses[dividendo.data.month - 1]){
          valor += dividendo.valor;
        }
      }
      total_ano += valor;
      dividendos_por_mes.add(valor);
    }
    return dividendos_por_mes;
  }


}