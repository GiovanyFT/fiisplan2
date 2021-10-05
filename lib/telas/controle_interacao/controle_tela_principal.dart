
import 'dart:async';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:fiisplan2/util/toast.dart';
import 'package:flutter/material.dart';

import '../tela_dividendos_impostos.dart';
import '../tela_grafico_patrimonios.dart';
import '../tela_listagem_compras.dart';
import '../tela_listagem_dividendos.dart';
import '../tela_listagem_vendas.dart';

class ControleTelaPrincipal {
  static const List<String> campos_ordenacao =
  ["Sigla - Crescente",
    "Sigla - Decrescente",
    "Nome - Crescente",
    "Nome - Decrescente",
    "Tipo - Crescente",
    "Tipo - Decrescente",
    "Quantidade de cotas - Crescente ",
    "Quantidade de cotas - Decrescente ",
    "Valor Médio - Crescente",
    "Valor Médio - Decrescente"];

  String campo_selecionado = "Sigla - Crescente";


  final streamController = StreamController<List<Patrimonio>>();


  late List<Patrimonio> patrimonios;
  Usuario usuario;

  ControleTelaPrincipal(this.usuario);

  bool _recarregar_patrimonios = false;

  void recarregarPatrimoniosQuantoVoltar(){
    _recarregar_patrimonios = true;
  }

  Future<List<Patrimonio>> buscarPatrimonios() async{
    patrimonios = await FabricaControladora.obterPatrimonioControl().obterPatrimonios(usuario, atributo : this.campo_selecionado);
    streamController.add(patrimonios);
    return patrimonios;
  }



  // Vai para a página selecionada e atualiza a TelaPrncipal se necessário
  Future irParaTelaEdicao(BuildContext context, Widget page) async {
    String s = await push(context, page);
    if (s == "Salvou") {
      patrimonios = await FabricaControladora.obterPatrimonioControl().obterPatrimonios(usuario, atributo: campo_selecionado);
      streamController.add(patrimonios);
    }
  }


  Future irParaTelaCompras(BuildContext context, Patrimonio patrimonio) async {
    await push(context, TelaListagemCompras(patrimonio, this));
    if (_recarregar_patrimonios) {
       patrimonios = await FabricaControladora.obterPatrimonioControl().obterPatrimonios(usuario, atributo: campo_selecionado);
       streamController.add(patrimonios);
      _recarregar_patrimonios = false;
    }
  }

  Future irParaTelaVendas(BuildContext context, Patrimonio patrimonio) async {
    await push(context, TelaListagemVendas(patrimonio, this));
    if (_recarregar_patrimonios) {
      patrimonios = await FabricaControladora.obterPatrimonioControl().obterPatrimonios(usuario, atributo: campo_selecionado);
      streamController.add(patrimonios);
      _recarregar_patrimonios = false;
    }
  }

  void removerPatrimonio(int index) async {
    Patrimonio patrimonio = patrimonios[index];
    int? qt_compras = await FabricaControladora.obterCompraControl().obterQuantidadeCompras(patrimonio);
    if (qt_compras! > 0){
      MensagemAlerta("Não é possível excluir o patrimônio (existem compras vinculadas a esse patrimônio) ");
    } else {
      patrimonio = patrimonios.removeAt(index);
      FabricaControladora.obterPatrimonioControl().removerPatrimonio(patrimonio);
      streamController.add(patrimonios);
    }
  }

  void irParaTelaGraficoPatrimonios(BuildContext context) {
    push(context, TelaGraficoPatrimonios(patrimonios));
  }

  void irParaTelaDividendosImpostos(BuildContext context) {
    push(context, TelaDividendosImpostos());
  }

  void irParaTelaDividendos(BuildContext context, Patrimonio patrimonio) {
    push(context, TelaListagemDividendos(patrimonio));
  }

}