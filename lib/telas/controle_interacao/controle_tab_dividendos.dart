
import 'dart:async';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:flutter/material.dart';

class ControleTabDividendos {
  final streamController = StreamController<List<Patrimonio>>();
  late List<Patrimonio> patrimonios;

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();

  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString();
  }

  Future<List<Patrimonio>> buscarPatrimonios({String atributo = "Sigla"}) async{
    Usuario? usuario = await Usuario.obter();
    patrimonios = await FabricaControladora.obterPatrimonioControl().obterPatrimonios(usuario!);
    streamController.add(patrimonios);
    return patrimonios;
  }

}