
import 'dart:async';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/compra.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:fiisplan2/util/toast.dart';
import 'package:flutter/material.dart';

import '../tela_edicao_compra.dart';
import 'controle_tela_principal.dart';

class ControleTelaListagemCompras {
  final streamController = StreamController<List<Compra>>();
  BuildContext context;

  Patrimonio patrimonio;
  ControleTelaPrincipal controleTelaPrincipal;
  List<Compra>? compras;

  ControleTelaListagemCompras(this.patrimonio, this.controleTelaPrincipal, this.context);

  // Controladores dos campos de edição
  final controlador_ano = TextEditingController();


  void setarAnoAtual(){
    this.controlador_ano.text = DateTime.now().year.toString(); ;
  }

  void setarMudanca(){
    controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
  }

  Future<List<Compra>?> buscarCompras() async{
    compras = await FabricaControladora.obterCompraControl().obterCompras(patrimonio, controlador_ano.text);
    streamController.add(compras!);
  }

  void irTelaEdicaoCompra(BuildContext context) async{
    String s = await push(context, TelaEdicaoCompra(patrimonio));
    if (s == "Salvou") {
      compras = await FabricaControladora.obterCompraControl().obterCompras(patrimonio, controlador_ano.text);
      streamController.add(compras!);
      controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
    }
  }

  void removerCompra(int index) {
    Compra compra = compras![index];
    if(patrimonio.qt_cotas - compra.quantidade < 0){
      MensagemErro(context, "Não é possível excluir essa Compra (exclua primeiro alguma(s) Vendas)");
    } else{
      compras!.removeAt(index);
      FabricaControladora.obterCompraControl().removerCompra(compra);
      streamController.add(compras!);
      controleTelaPrincipal.recarregarPatrimoniosQuantoVoltar();
    }
  }
}