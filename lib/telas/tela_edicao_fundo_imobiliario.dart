import 'package:fiisplan2/dominio/fundo_imobiliario.dart';
import 'package:fiisplan2/util/widgets/botao.dart';
import 'package:fiisplan2/util/widgets/campo_edicao.dart';
import 'package:fiisplan2/util/widgets/seletor_opcoes.dart';
import 'package:flutter/material.dart';

import '../dominio/patrimonio.dart';
import 'controle_interacao/controle_tela_edicao_fundo_imobiliario.dart';


class TelaEdicaoFundoImobiliario extends StatefulWidget {
  FundoImobiliario? fundo;
  Patrimonio? patrimonio;

  TelaEdicaoFundoImobiliario(this.fundo, this.patrimonio);

  @override
  _TelaEdicaoFundoImobiliarioState createState() => _TelaEdicaoFundoImobiliarioState();
}

class _TelaEdicaoFundoImobiliarioState extends State<TelaEdicaoFundoImobiliario> {
  late ControleTelaEdicaoFundoImobiliario _controle;

  @override
  void initState() {
    super.initState();
    _controle = ControleTelaEdicaoFundoImobiliario(widget.fundo, widget.patrimonio);
    _controle.inicializar_campos_edicao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edição de Fundo Imobiliário"),
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
            children: (widget.fundo == null) ?
                      _mostrarCamposFundoNovo() :
                      _mostrarCamposFundoPreExistente()
          ),
        ),
      ),
    );
  }

  List<Widget> _mostrarCamposFundoNovo() {
    return <Widget>[
            CampoEdicao(
              "Sigla:",
              controlador: _controle.controlador_sigla,
              recebedor_foco: _controle.focus_nome,
            ),
            SizedBox(
              height: 10,
            ),
            CampoEdicao(
              "Nome:",
              controlador: _controle.controlador_nome,
              marcador_foco: _controle.focus_nome,
              recebedor_foco: _controle.focus_segmento,
            ),
            SizedBox(
              height: 10,
            ),
            SeletorOpcoes(
              opcoes: SegmentoFundoImobiliario.todos,
              valor_selecionado: _controle.segmento_selecionado,
              ao_mudar_opcao: (String novoItemSelecionado){
                _controle.segmento_selecionado = novoItemSelecionado;
              },
              marcador_foco: _controle.focus_segmento,
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
                      _controle.salvar_fundo_imobiliario(context);
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
          ];
  }

  List<Widget> _mostrarCamposFundoPreExistente() {
    return <Widget>[
      CampoEdicao(
        "Sigla:",
        controlador: _controle.controlador_sigla,
        recebedor_foco: _controle.focus_nome,
      ),
      SizedBox(
        height: 10,
      ),
      CampoEdicao(
        "Nome:",
        controlador: _controle.controlador_nome,
        marcador_foco: _controle.focus_nome,
        recebedor_foco: _controle.focus_segmento,
      ),
      SizedBox(
        height: 10,
      ),
      SeletorOpcoes(
        opcoes: SegmentoFundoImobiliario.todos,
        valor_selecionado: _controle.segmento_selecionado,
        ao_mudar_opcao: (String novoItemSelecionado){
          _controle.segmento_selecionado = novoItemSelecionado;
        },
        marcador_foco: _controle.focus_segmento,
      ),
      SizedBox(
        height: 10,
      ),
      CampoEdicao(
        "Preço Médio:",
        controlador: _controle.controlador_preco_medio,
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
                _controle.salvar_fundo_imobiliario(context);
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
    ];
  }
}
