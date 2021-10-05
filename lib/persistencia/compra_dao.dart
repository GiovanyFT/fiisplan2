
import 'package:fiisplan2/dominio/compra.dart';
import 'package:fiisplan2/persistencia/transacao_dao.dart';

class CompraDAO extends TransacaoDAO<Compra>{

  @override
  String get nomeTabela => "COMPRA";

  @override
  Compra fromMap(Map<String, dynamic> map) {
    return Compra.fromMap(map);
  }
}
