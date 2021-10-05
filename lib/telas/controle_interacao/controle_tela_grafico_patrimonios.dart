


import 'package:fiisplan2/dominio/patrimonio.dart';

class ControleTelaGraficoPatrimonios{
  List<Patrimonio> patrimonios;

  List<String> labels = <String>[];
  List<double> valores = <double>[];
  String titulo;

  ControleTelaGraficoPatrimonios(this.patrimonios, this.titulo){
    for(Patrimonio patrimonio in patrimonios){
      labels.add(patrimonio.fundo.sigla);
      valores.add((patrimonio.qt_cotas * patrimonio.valor_medio));
    }
  }

}