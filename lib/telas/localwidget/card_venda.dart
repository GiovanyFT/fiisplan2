import 'package:fiisplan2/dominio/venda.dart';
import 'package:fiisplan2/telas/controle_interacao/controle_tela_listagem_vendas.dart';
import 'package:fiisplan2/util/widgets/botao_icone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardVenda extends StatelessWidget {
  ControleTelaListagemVendas controle;
  Venda venda;
  int index;


  CardVenda(this.venda, this.controle, this.index);

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
                  venda.obterDataTransacao(),
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
                      venda.valor_cota.toStringAsFixed(2),
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
                      venda.taxa.toStringAsFixed(2),
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
                      venda.quantidade.toString(),
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
                  controle.removerVenda(index);
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
