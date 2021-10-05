import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/widgets/botao.dart';
import 'package:fiisplan2/util/widgets/campo_edicao.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_data.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_double_maior_que_zero.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_int_maior_que_zero.dart';
import 'package:flutter/material.dart';

import 'controle_interacao/controle_tela_edicao_compra.dart';


class TelaEdicaoCompra extends StatefulWidget {
  Patrimonio patrimonio;

  TelaEdicaoCompra(this.patrimonio);

  @override
  _TelaEdicaoCompraState createState() => _TelaEdicaoCompraState();
}

class _TelaEdicaoCompraState extends State<TelaEdicaoCompra> {
  late ControleTelaEdicaoCompra _controle;

  @override
  void initState() {
    super.initState();
    _controle = ControleTelaEdicaoCompra(widget.patrimonio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inclusão de Compra de FII"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _controle.formkey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CampoEdicaoData(
                "Data de Compra:",
                controlador: _controle.controlador_data_compra,
                recebedor_foco: _controle.focus_valor_cota,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicaoDoubleMaiorQueZero(
                "Valor da Cota:",
                controlador: _controle.controlador_valor_cota,
                marcador_foco: _controle.focus_valor_cota,
                recebedor_foco: _controle.focus_quantidade_cotas,
                teclado: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicaoIntMaiorQueZero(
                "Quantidade de cotas:",
                controlador: _controle.controlador_quantidade_cotas,
                marcador_foco: _controle.focus_quantidade_cotas,
                recebedor_foco: _controle.focus_taxas,
                teclado: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicao(
                "Taxas:",
                controlador: _controle.controlador_taxas,
                marcador_foco: _controle.focus_taxas,
                recebedor_foco: _controle.focus_botao_salvar,
                validador: _controle.validarTaxas,
                teclado: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Botao(
                      texto: "Salvar",
                      cor: Colors.green,
                      ao_clicar: () {
                        _controle.salvar_compra(context);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Botao(
                      texto: "Cancelar",
                      cor: Colors.green,
                      ao_clicar: () {
                        _controle.inicializar_campos_edicao();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
