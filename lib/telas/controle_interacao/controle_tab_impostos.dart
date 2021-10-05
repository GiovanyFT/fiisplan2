
import 'dart:async';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/imposto.dart';
import 'package:fiisplan2/util/meses_ano.dart';
import 'package:flutter/material.dart';

class ControleTabImpostos {
  final streamController = StreamController<List<Imposto>>();
  late List<Imposto> impostos;

  final List<String> meses = MesesAno.meses;
  String mes_selecionado = MesesAno.janeiro;

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();

  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString();
  }

  Future<List<Imposto>> gerarImpostos() async{
    impostos = await FabricaControladora.obterImpostoControl().gerarImpostos(controlador_ano.text, mes_selecionado);
    print("Impostos gerados");
    streamController.add(impostos);
    return impostos;
  }

}