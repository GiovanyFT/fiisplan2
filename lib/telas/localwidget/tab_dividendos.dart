import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/telas/controle_interacao/controle_tab_dividendos.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_int_maior_que_zero.dart';
import 'package:flutter/material.dart';

import 'card_sumarizacao_dividendos.dart';


class TabDividendos extends StatefulWidget {
  @override
  _TabDividendosState createState() => _TabDividendosState();
}

class _TabDividendosState extends State<TabDividendos> {
  late ControleTabDividendos _controle;


  @override
  void initState() {
    super.initState();
    _controle = ControleTabDividendos();
    _controle.setarAnoAtual();
    _controle.buscarPatrimonios();
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
            height: 30,
          ),
          Expanded(
            flex: 8,
            child: RefreshIndicator(
              onRefresh: (){
                return _controle.buscarPatrimonios();
              },
              child: _stream_builder(),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<List<Patrimonio>> _stream_builder() {
    return StreamBuilder<List<Patrimonio>>(
        stream: _controle.streamController.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controle.patrimonios = snapshot.data!;
          return _listView();
        }
    );
  }

  ListView _listView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _controle.patrimonios != null ? _controle.patrimonios.length : 0,
      itemBuilder: (context, index) {
        Patrimonio patrimonio = _controle.patrimonios[index];
        return CardSumarizacaoDividendos(patrimonio, _controle.controlador_ano.text);
      },
    );
  }
}
