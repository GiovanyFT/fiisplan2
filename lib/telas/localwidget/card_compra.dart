import 'package:fiisplan2/dominio/compra.dart';
import 'package:fiisplan2/telas/controle_interacao/controle_tela_listagem_compras.dart';
import 'package:fiisplan2/util/widgets/botao_icone.dart';
import 'package:flutter/material.dart';


class CardCompra extends StatelessWidget {
  ControleTelaListagemCompras controle;
  Compra compra;
  int index;


  CardCompra(this.compra, this.controle, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        height: 120,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  compra.obterDataTransacao(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 25),
                    child: Text(
                      compra.valor_cota.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 25),
                    child: Text(
                      compra.taxa.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 25),
                    child: Text(
                      compra.quantidade.toString(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: BotaoIcone(
             //   texto: "Excluir",
                ao_clicar: () async {
                  controle.removerCompra(index);
                },
                cor: Colors.red,
                icone: Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
