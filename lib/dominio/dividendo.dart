

import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/formatacao.dart';

import 'objeto.dart';

class Dividendo extends Objeto{
  late DateTime data;
  late double valor;
  late Patrimonio patrimonio;


  Dividendo({required this.data, required this.valor, required this.patrimonio});

  Dividendo.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    data = gerarDateTime(map["data"])!;
    valor = map["valor"];
  }

  String obterDataTransacao(){
    return formatarDateTime(data);
  }

}