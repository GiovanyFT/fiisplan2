
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/transacao.dart';

class Venda extends Transacao{
  late double valor_medio_compra;

  Venda({required DateTime data_transacao, required double valor_cota, required int quantidade, required double taxa, required Patrimonio patrimonio})
      : super(data_transacao, valor_cota, quantidade, taxa, patrimonio){
    this.valor_medio_compra = patrimonio.valor_medio;
  }

  Venda.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    this.valor_medio_compra = map["valor_medio_compra"];
  }

}