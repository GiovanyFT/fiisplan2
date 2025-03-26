
import 'package:fiisplan2/dominio/fundo_imobiliario.dart';
import 'package:fiisplan2/persistencia/fundo_imobiliario_dao.dart';

class FundoImobiliarioControl {
  FundoImobiliarioDAO _dao = FundoImobiliarioDAO();

  void atualizarFundoImobiliario(FundoImobiliario fundo){
    _dao.atualizar(fundo);
  }
}