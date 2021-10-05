import 'package:fiisplan2/dominio/imposto.dart';
import 'package:fiisplan2/telas/controle_interacao/controle_tab_impostos.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_int_maior_que_zero.dart';
import 'package:fiisplan2/util/widgets/seletor_opcoes.dart';
import 'package:flutter/material.dart';

import 'card_imposto.dart';


class TabImpostos extends StatefulWidget {
  @override
  _TabImpostosState createState() => _TabImpostosState();
}

class _TabImpostosState extends State<TabImpostos> {
  late ControleTabImpostos _controle;

  @override
  void initState() {
    super.initState();
    _controle = ControleTabImpostos();
    _controle.setarAnoAtual();
    _controle.gerarImpostos();
  }

  @override
  void dispose() {
    super.dispose();
    _controle.streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CampoEdicaoIntMaiorQueZero(
              "Ano:",
              texto_dica: "Digite o ano",
              controlador: _controle.controlador_ano,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: SeletorOpcoes(
              opcoes: _controle.meses,
              valor_selecionado: _controle.mes_selecionado,
              ao_mudar_opcao: (String novoItemSelecionado) {
                _controle.mes_selecionado = novoItemSelecionado;
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: RefreshIndicator(
              onRefresh: () {
                return _controle.gerarImpostos();
              },
              child: _stream_builder(),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<List<Imposto>> _stream_builder() {
    return StreamBuilder<List<Imposto>>(
        stream: _controle.streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controle.impostos = snapshot.data!;
          return _listView();
        });
  }

  ListView _listView() {
    if ((_controle.impostos == null) || (_controle.impostos.length == 0))
      return ListView();
    else
      return ListView.builder(
        // shrinkWrap: true, permite colocar um ListView dentro de uma Coluna sem delimitar o tamanho
        // do ListView (usando Expanded ou Sized Box)
        // Column(
        //  children: <Widget>[
        //    Expanded( // wrap in Expanded
        //      child: ListView(...),
        //    ),
        //  ],
        //)
        //Column(
        //  children: <Widget>[
        //    SizedBox(
        //      height: 400, // fixed height
        //      child: ListView(...),
        //    ),
        //  ],
        //)
        shrinkWrap: true,
        itemCount: _controle.impostos.length,
        itemBuilder: (context, index) {
          Imposto imposto = _controle.impostos[index];
          return CardImposto(imposto);
        },
      );
  }
}
