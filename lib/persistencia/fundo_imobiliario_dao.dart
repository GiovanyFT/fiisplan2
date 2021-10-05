
import 'package:fiisplan2/dominio/fundo_imobiliario.dart';

import 'base_dao.dart';

class FundoImobiliarioDAO extends BaseDAO<FundoImobiliario>{
  @override
  String get nomeTabela => "FUNDO_IMOBILIARIO";

  @override
  FundoImobiliario fromMap(Map<String, dynamic > map) {
    return FundoImobiliario.fromMap(map);
  }

  void atualizar(FundoImobiliario fundo) async{
    this.atualizarBase(
        colunas: ["sigla", "nome", "segmento"],
        nomes_filtros: [ "id" ],
        valores : [fundo.sigla, fundo.nome, fundo.segmento, fundo.id]
    );
  }
}
