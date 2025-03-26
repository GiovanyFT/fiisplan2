

import 'package:fiisplan2/dominio/fundo_imobiliario.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/persistencia/patrimonio_dao.dart';
import 'package:fiisplan2/telas/controle_interacao/controle_tela_principal.dart';

class PatrimonioControl{
  PatrimonioDAO _dao = PatrimonioDAO();

  Future<List<Patrimonio>> obterPatrimonios(Usuario usuario, {String atributo = "Sigla - Crescente"}) async{
    List<Patrimonio> patrimonios = await _dao.obterLista(usuario);
    if(atributo == ControleTelaPrincipal.campos_ordenacao[0]){
      patrimonios.sort(patrimonioPorSiglaFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[1]){
      patrimonios.sort(patrimonioPorSiglaFundoDesc);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[2]){
      patrimonios.sort(patrimonioPorNomeFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[3]){
      patrimonios.sort(patrimonioPorNomeFundoDesc);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[4]){
      patrimonios.sort(patrimonioPorTipoFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[5]){
      patrimonios.sort(patrimonioPorTipoFundoDesc);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[6]){
      patrimonios.sort(patrimonioPorQtCotaFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[7]){
      patrimonios.sort(patrimonioPorQtCotaFundoDesc);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[8]){
      patrimonios.sort(patrimonioPorValorMedioFundo);
    } else if (atributo == ControleTelaPrincipal.campos_ordenacao[9]){
      patrimonios.sort(patrimonioPorValorMedioFundoDesc);
    }else if (atributo == ControleTelaPrincipal.campos_ordenacao[3]){
      patrimonios.sort(patrimonioPorNomeFundoDesc);
    }
    return patrimonios;
  }

  void criarNovoPatrimonio(FundoImobiliario fundo, Usuario usuario) {
    Patrimonio patrimonio = Patrimonio( fundo: fundo,
                                        usuario: usuario,
                                        valor_medio: 0.0,
                                        qt_cotas:  0);
    _dao.incluir(patrimonio);
  }

  void removerPatrimonio(Patrimonio patrimonio) {
    _dao.remover(patrimonio);
  }

  Future<int?> obterQuantidadePatrimonios(Usuario usuario) async{
    return _dao.obterQuantidade(usuario);
  }

  void atualizarPrecoMedio(Patrimonio patrimonio){
    _dao.atualizar(patrimonio);
  }
}