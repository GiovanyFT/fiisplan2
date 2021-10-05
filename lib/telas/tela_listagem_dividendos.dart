import 'package:fiisplan2/dominio/dividendo.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_int_maior_que_zero.dart';
import 'package:flutter/material.dart';

import 'controle_interacao/controle_tela_listagem_dividendos.dart';
import 'localwidget/card_dividendo.dart';

class TelaListagemDividendos extends StatefulWidget {
  Patrimonio patrimonio;

  TelaListagemDividendos(this.patrimonio);

  @override
  _TelaListagemDividendosState createState() => _TelaListagemDividendosState();
}

class _TelaListagemDividendosState extends State<TelaListagemDividendos> {
  late ControleTelaListagemDividendos _controle;

  @override
  void initState() {
    super.initState();
    _controle = ControleTelaListagemDividendos(widget.patrimonio);
    _controle.setarAnoAtual();
    _controle.buscarDividendos();
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
        title: Text("Dividendos"),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controle.irTelaEdicaoDividendo(context);
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
              return _controle.buscarDividendos();
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
    child: StreamBuilder<List<Dividendo>>(
        stream: _controle.streamController.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controle.dividendos = snapshot.data;
          return _listView();
        }
    ),
  );
  }

  ListView _listView() {
    return ListView.builder(
      itemCount: _controle.dividendos != null ? _controle.dividendos!.length : 0,
      itemBuilder: (context, index) {
        Dividendo dividendo = _controle.dividendos![index];
        return CardDividendo(dividendo, _controle, index);
      },
    );
  }
}
