import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/widgets/botao.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_data.dart';
import 'package:fiisplan2/util/widgets/campo_edicao_double_maior_que_zero.dart';
import 'package:flutter/material.dart';

import 'controle_interacao/controle_tela_edicao_dividendo.dart';

class TelaEdicaoDividendo extends StatefulWidget {
  Patrimonio patrimonio;


  TelaEdicaoDividendo(this.patrimonio);

  @override
  _TelaEdicaoDividendoState createState() => _TelaEdicaoDividendoState();
}

class _TelaEdicaoDividendoState extends State<TelaEdicaoDividendo> {
  late ControleTelaEdicaoDividendo _controle;

@override
  void initState() {
    super.initState();
    _controle = ControleTelaEdicaoDividendo(widget.patrimonio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inclusão de Dividendo"),
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
                "Data:",
                controlador: _controle.controlador_data,
                recebedor_foco: _controle.focus_valor,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicaoDoubleMaiorQueZero(
                "Valor:",
                controlador: _controle.controlador_valor,
                marcador_foco: _controle.focus_valor,
                recebedor_foco: _controle.focus_botao_salvar,
                teclado: TextInputType.number,
              ),
              SizedBox(
                height: 10,
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
                        _controle.salvar_dividendo(context);
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
