import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/telas/controle_interacao/controle_card_sumarizacao_dividendos.dart';
import 'package:fiisplan2/util/formatacao.dart';
import 'package:fiisplan2/util/meses_ano.dart';
import 'package:flutter/material.dart';

class CardSumarizacaoDividendos extends StatelessWidget {
  late ControleCardSumarizacaoDividendos _controle;

  Patrimonio patrimonio;
  String text_ano;

  CardSumarizacaoDividendos(this.patrimonio, this.text_ano);

  @override
  Widget build(BuildContext context) {
    _controle = ControleCardSumarizacaoDividendos(patrimonio, text_ano);
    return Card(
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        patrimonio.fundo.sigla,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        patrimonio.fundo.nome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              _cabecalho(),
              SizedBox(
                height: 10,
              ),
              _meses_dividendos(),
            ],
          )),
    );
  }

  _cabecalho() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.only(right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 100,
              alignment: Alignment.centerLeft,
              child: Text(
                "Mês",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              width: 100,
              alignment: Alignment.center,
              child: Text(
                "Dividendos",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _meses_dividendos() {
    Future<List<double>> future = _controle.gerarDividendosPorMes();
    return FutureBuilder<List<double>>(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _controle.dividendos_por_mes = snapshot.data!;
        return _body();
      },
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        _listView(),
        Divider(),
         _sumarizacao(),
      ],
    );
  }

  ListView _listView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _controle.dividendos_por_mes != null
          ? _controle.dividendos_por_mes.length
          : 0,
      itemBuilder: (context, index) {
        double valor = _controle.dividendos_por_mes[index];
        String mes = MesesAno.meses[index];
        return _itemMes(mes, valor);
      },
    );
  }

  _itemMes(String mes, double valor) {
    return Container(
      padding: EdgeInsets.only(right: 16),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              mes,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              formatarNumero(valor),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _sumarizacao() {
    return Container(
      padding: EdgeInsets.only(right: 16),
      alignment: Alignment.bottomRight,
      child: _controle.total_ano == null ? Text("") : Text(
              "TOTAL:  ${formatarNumero(_controle.total_ano)}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
