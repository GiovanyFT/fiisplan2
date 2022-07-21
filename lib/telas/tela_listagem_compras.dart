import 'package:fiisplan2/dominio/compra.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_int_maior_que_zero.dart';
import 'package:flutter/material.dart';

import 'controle_interacao/controle_tela_listagem_compras.dart';
import 'controle_interacao/controle_tela_principal.dart';
import 'localwidget/card_compra.dart';



class TelaListagemCompras extends StatefulWidget {
  Patrimonio patrimonio;
  ControleTelaPrincipal controleTelaPrincipal;

  TelaListagemCompras(this.patrimonio, this.controleTelaPrincipal, context);

  @override
  _TelaListagemComprasState createState() => _TelaListagemComprasState();
}

class _TelaListagemComprasState extends State<TelaListagemCompras> {
  late ControleTelaListagemCompras _controle;

  @override
  void initState() {
    super.initState();
    _controle = ControleTelaListagemCompras(
        widget.patrimonio, widget.controleTelaPrincipal, context);
    _controle.setarAnoAtual();
    _controle.buscarCompras();
  }

  @override
  void dispose() {
    super.dispose();
    _controle.streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compras"),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controle.irTelaEdicaoCompra(context);
        },
      ),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(top:  16, left: 16, right: 16),
            child: CampoEdicaoIntMaiorQueZero(
              "Ano:",
              texto_dica: "Digite o ano",
              tamanho_fonte: 20,
              controlador: _controle.controlador_ano,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        Expanded(
          flex: 10,
          child: RefreshIndicator(
            onRefresh: (){
              return _controle.buscarCompras();
            },
            child: _stream_builder(),
          ),
        ),
      ],
    );
  }

  Container _stream_builder() {
    return Container(
    padding: EdgeInsets.all(16),
    child: StreamBuilder<List<Compra>>(
      stream: _controle.streamController.stream,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _controle.compras = snapshot.data!.cast<Compra>();
        return _listView();
      }
    ),
  );
  }

  ListView _listView() {
    return ListView.builder(
      itemCount: _controle.compras != null ? _controle.compras!.length : 0,
      itemBuilder: (context, index) {
        Compra compra = _controle.compras![index];
        return CardCompra(compra, _controle, index);
      },
    );
  }
}
