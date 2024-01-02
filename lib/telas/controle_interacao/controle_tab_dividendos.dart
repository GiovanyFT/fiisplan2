
import 'dart:async';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:flutter/material.dart';

import '../../dominio/dividendo.dart';


class ControleTabDividendos {
  final streamController = StreamController<List<Patrimonio>>();
  late List<Patrimonio> patrimonios;

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();

  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString();
  }

  Future<double> gerarTotalDividendosAno(Patrimonio patrimonio) async{
    double total_ano = 0;
    List<Dividendo> dividendos = await FabricaControladora.obterDividendoControl().obterDividendos(patrimonio, this.controlador_ano.text);
    for(Dividendo dividendo in dividendos){
      total_ano += dividendo.valor;
    }
    return total_ano;
  }

  // Retira os patrimônios com total de dividendos no ano igual a 0
  // Esses patrimônios, na prática, não colaboram para visualizar os
  // dividendos obtidos no ano
  Future<List<Patrimonio>> retirarPatrimoniosDividendo0(List<Patrimonio> patrimonios_usuario) async{
    patrimonios = [];
    for(Patrimonio patrimonio in patrimonios_usuario){
      double total_ano = await this.gerarTotalDividendosAno(patrimonio);
      if( total_ano > 0) {
        patrimonios.add(patrimonio);
      }
    }
    if (patrimonios.isEmpty)
      return patrimonios_usuario;
    else
      return patrimonios;
  }



  Future<List<Patrimonio>> buscarPatrimonios({String atributo = "Sigla"}) async{
    Usuario? usuario = await Usuario.obter();
    List<Patrimonio> patrimonios_usuario = await FabricaControladora.obterPatrimonioControl().obterPatrimonios(usuario!);
    patrimonios = await retirarPatrimoniosDividendo0(patrimonios_usuario);
    streamController.add(patrimonios);
    return patrimonios;
  }

}