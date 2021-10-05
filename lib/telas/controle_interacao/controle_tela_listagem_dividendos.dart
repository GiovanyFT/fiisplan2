
import 'dart:async';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/dividendo.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:flutter/material.dart';

import '../tela_edicao_dividendo.dart';


class ControleTelaListagemDividendos{
  final streamController = StreamController<List<Dividendo>>();
  Patrimonio patrimonio;
  List<Dividendo>? dividendos;

  ControleTelaListagemDividendos(this.patrimonio);

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();


  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString(); ;
  }

  Future<List<Dividendo>?> buscarDividendos() async{
    dividendos = await FabricaControladora.obterDividendoControl().obterDividendos(patrimonio, controlador_ano.text);
    streamController.add(dividendos!);
    return dividendos;
  }


  void irTelaEdicaoDividendo(BuildContext context) async{
    String s = await push(context, TelaEdicaoDividendo(patrimonio));
    if (s == "Salvou") {
      dividendos = await FabricaControladora.obterDividendoControl().obterDividendos(patrimonio, controlador_ano.text);
      streamController.add(dividendos!);
    }
  }

  void removerDividendo(int index) {
    Dividendo dividendo = dividendos![index];
    dividendos!.removeAt(index);
    FabricaControladora.obterDividendoControl().removerDividendo(dividendo);
    streamController.add(dividendos!);
  }


}