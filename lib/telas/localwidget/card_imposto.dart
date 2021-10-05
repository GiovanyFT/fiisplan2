import 'package:fiisplan2/dominio/imposto.dart';
import 'package:fiisplan2/dominio/venda.dart';
import 'package:fiisplan2/telas/controle_interacao/controle_card_imposto.dart';
import 'package:fiisplan2/util/formatacao.dart';
import 'package:flutter/material.dart';


class CardImposto extends StatelessWidget {
  Imposto imposto;
  late ControleCardImposto _controle;

  CardImposto(this.imposto);
  

  @override
  Widget build(BuildContext context) {
    _controle = ControleCardImposto(imposto);
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
                      imposto.vendas.length > 0 ? imposto.vendas[0].patrimonio.fundo.sigla : "",
                      maxLines: 1,
                      overflow : TextOverflow.ellipsis,
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
                      imposto.vendas.length > 0 ?  imposto.vendas[0].patrimonio.fundo.nome : "",
                      maxLines: 1,
                      overflow : TextOverflow.ellipsis,
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
            _dadosVenda(),
            SizedBox(
              height: 10,
            ),
            _sumarizacao(),
          ],
        ),
      ),

    );
  }

   _cabecalho(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              "Valor de Venda",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 40,
          ),
          Flexible(
            flex: 1,
            child: Text(
              "Valor Médio Gasto (compra)",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Resultado",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
   }

   _dadosVenda(){
     return ListView.builder(
       shrinkWrap: true,
       itemCount: imposto.vendas != null ? imposto.vendas.length : 0,
       itemBuilder: (context, index) {
         Venda venda = imposto.vendas[index];
         return _itemVenda(venda);
       },
     );
  }

  _itemVenda(Venda venda) {
    _controle.gerarValoresItemVenda(venda);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Text(
              _controle.valor_venda_texto,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            flex: 1,
            child: Text(
              " - ",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              _controle.valor_compra_texto,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            flex: 1,
            child: Text(
              " = ",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              _controle.resultado,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sumarizacao() {
    return Column(
      children: <Widget>[
        Divider(),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "TOTAL:  ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatarNumero(_controle.calcularValorTotal()),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Imposto a pagar:  ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatarNumero(_controle.calcularImposto()),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
