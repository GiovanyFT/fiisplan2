
import 'dart:async';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/venda.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:flutter/material.dart';

import '../tela_edicao_venda.dart';
import 'controle_tela_principal.dart';

class ControleTelaListagemVendas {
  final streamController = StreamController<List<Venda>>();

  Patrimonio patrimonio;
  ControleTelaPrincipal controleTelaPrincipal;
  List<Venda>? vendas;

  ControleTelaListagemVendas(this.patrimonio, this.controleTelaPrincipal, context);

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();


  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString(); ;
  }

  void setarMudanca(){
    controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
  }

  Future<List<Venda>?> buscarVendas() async{
    vendas = await FabricaControladora.obterVendaControl().obterVendas(patrimonio,  controlador_ano.text);
    streamController.add(vendas!);
  }

  void irTelaEdicaoVenda(BuildContext context) async{
    String s = await push(context, TelaEdicaoVenda(patrimonio, context));
    if (s == "Salvou") {
      vendas = await FabricaControladora.obterVendaControl().obterVendas(patrimonio, controlador_ano.text);
      streamController.add(vendas!);
      controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
    }
  }

  void removerVenda(int index) {
    Venda venda = vendas!.removeAt(index);
    FabricaControladora.obterVendaControl().removerVenda(venda);
    streamController.add(vendas!);
    controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
  }
}