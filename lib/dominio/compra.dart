
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/transacao.dart';

Comparator<Compra> compraPorData = (c1, c2) => c1.data_transacao.compareTo(c2.data_transacao);


class Compra extends Transacao{
  Compra({required DateTime data_transacao, required double valor_cota, required int quantidade, required double taxa, required Patrimonio patrimonio})
      : super(data_transacao, valor_cota, quantidade, taxa, patrimonio);

  Compra.fromMap(Map<String, dynamic> map) : super.fromMap(map);

}