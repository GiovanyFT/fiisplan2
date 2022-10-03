
import 'package:fiisplan2/dominio/dividendo.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/persistencia/dividendo_dao.dart';


class DividendoControl{
  DividendoDAO _dao = DividendoDAO();

  Future<List<Dividendo>> obterDividendos(Patrimonio patrimonio, String texto_ano) async{
    List<Dividendo> dividendos = await _dao.obterLista(patrimonio);

    List<Dividendo> dividendos_ano = <Dividendo>[];
    for(Dividendo dividendo in dividendos){
      int ano = dividendo.data.year;
      if(ano == int.parse(texto_ano)){
        dividendos_ano.add(dividendo);
      }
    }
    dividendos_ano.sort(dividendoPorData);
    return dividendos_ano;
  }

  void inserirDividendo(Dividendo dividendo){
    _dao.inserir(dividendo);
  }

  void removerDividendo(Dividendo dividendo) {
    _dao.excluir(dividendo);
  }
}