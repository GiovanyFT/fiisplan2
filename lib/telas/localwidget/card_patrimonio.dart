import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/telas/controle_interacao/controle_tela_principal.dart';
import 'package:fiisplan2/util/widgets/botao_icone.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardPatrimonio extends StatelessWidget {
  ControleTelaPrincipal controle;
  Patrimonio patrimonio;

  CardPatrimonio(this.patrimonio, this.controle);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                patrimonio.fundo.sigla,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    patrimonio.fundo.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14
                    ),
                  ),
                  Text(
                    patrimonio.fundo.segmento,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  Text(
                    "Quantidade de Cotas",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  Text(
                    "${patrimonio.qt_cotas}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  Text(
                    "Valor médio",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  Text(
                    "${patrimonio.valor_medio.toStringAsFixed(2)}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: BotaoIcone(
                        ao_clicar: () async {
                          await controle.irParaTelaCompras(context, patrimonio);
                        },
                        cor: Colors.green,
                        icone: FontAwesomeIcons.cartPlus,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex: 1,
                      child: BotaoIcone(
                        ao_clicar: () async {
                          await  controle.irParaTelaVendas(context, patrimonio);
                        },
                        cor: Colors.yellow,
                        icone: FontAwesomeIcons.cartArrowDown,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex: 1,
                      child: BotaoIcone(
                        ao_clicar: () {
                          controle.irParaTelaDividendos(context, patrimonio);
                        },
                        cor: Colors.amber,
                        icone:  FontAwesomeIcons.handHoldingUsd,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
