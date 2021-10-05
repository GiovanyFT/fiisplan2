
import 'package:fiisplan2/dominio/dividendo.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/formatacao.dart';

import 'base_dao.dart';

class DividendoDAO extends BaseDAO<Dividendo> {

  @override
  String get nomeTabela => "DIVIDENDO";


  @override
  Dividendo fromMap(Map<String, dynamic> map) {
    return Dividendo.fromMap(map);
  }

  Future<List<Dividendo>> obterLista(Patrimonio patrimonio) async{
    List<Dividendo> dividendos = await this.obterListaBase(
        nomes_filtros : ["id_patrimonio"],
        valores : [patrimonio.id]);
    for(Dividendo dividendo in dividendos){
      dividendo.patrimonio = patrimonio;
    }
    return dividendos;
  }

  Future<int> excluir(Dividendo dividendo) async {
    return this.excluirBase(
      nomes_filtros: ["id"],
      valores: [dividendo.id],
    );
  }

  Future<int> inserir(Dividendo dividendo) async{
    return this.inserirBase(
        colunas : ["data", "valor", "id_patrimonio"],
        valores: [formatarDateTime(dividendo.data), dividendo.valor, dividendo.patrimonio.id]);
  }
}