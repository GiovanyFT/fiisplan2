import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/telas/tela_edicao_fundo_imobiliario.dart';
import 'package:fiisplan2/telas/tela_webview_fundos.dart';
import 'package:fiisplan2/util/firebase_cloud_messaging.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:fiisplan2/util/widgets/seletor_opcoes.dart';
import 'package:flutter/material.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'controle_interacao/controle_tela_principal.dart';
import 'localwidget/card_patrimonio.dart';
import 'localwidget/menu_lateral.dart';



class TelaPrincipal extends StatefulWidget {
  final Usuario usuario;

  TelaPrincipal(this.usuario);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  late ControleTelaPrincipal _controle;

  @override
  void initState() {
    super.initState();
    _controle = ControleTelaPrincipal(widget.usuario, context);
    _controle.buscarPatrimonios();

    TratadorNotificacao.inicializarFCM(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controle.streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patrimônio"),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.chartPie,
            ),
            onPressed: () {
              _controle.irParaTelaGraficoPatrimonios(context);
            },
          ),
          IconButton(
            icon: FaIcon(
              //,
              FontAwesomeIcons.magnifyingGlassDollar,
            ),
            onPressed: () {
              _controle.irParaTelaDividendosImpostos(context);
            },
          ),
          PopupMenuButton<String>(
            icon: FaIcon(FontAwesomeIcons.chrome),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () { push(context, TelaWebViewFundos("https://www.clubefii.com.br/fundo_imobiliario_lista")); },
                    child: Text(
                      "Clube FII",
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () { push(context, TelaWebViewFundos("https://fiis.com.br/lista-de-fundos-imobiliarios/")); },
                    child: Text(
                      "FIIs.com.br",
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () { push(context, TelaWebViewFundos("https://www.fundsexplorer.com.br/funds")); },
                    child: Text(
                      "Fundsexplorer",
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await _controle.irParaTelaEdicao(
              context, TelaEdicaoFundoImobiliario(null, null));
        },
      ),
      drawer: MenuLateral(),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: SeletorOpcoes(
                    tamanho_fonte: 20,
                    opcoes: ControleTelaPrincipal.campos_ordenacao,
                    valor_selecionado: _controle.campo_selecionado,
                    ao_mudar_opcao: (String novoItemSelecionado) {
                      _controle.campo_selecionado = novoItemSelecionado;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Expanded(
          flex: 8,
          child: RefreshIndicator(
            onRefresh: () {
              return _controle.buscarPatrimonios();
            },
            child: StreamBuilder<List<Patrimonio>>(
                stream: _controle.streamController.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  _controle.patrimonios = snapshot.data!;
                  return _listView();
                }),
          ),
        ),
      ],
    );
  }

  Container _listView() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _controle.patrimonios.length,
        itemBuilder: (context, index) {
          Patrimonio patrimonio = _controle.patrimonios[index];
          return GestureDetector(
            onTap: () {
              _showDialog(index, patrimonio);
            },
            child: CardPatrimonio(patrimonio, _controle),
          );
        },
      ),
    );
  }

  void _showDialog(int index, Patrimonio patrimonio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Edição de Fundo Imobiliário"),
          content:
              new Text("O que você deseja fazer com esse fundo imobiliário?"),
          actions: <Widget>[
            // define os botões na base do dialogo
            TextButton(
              child: new Text("Alterar"),
              onPressed: () async {
                pop(context);
                _controle.irParaTelaEdicao(
                    context, TelaEdicaoFundoImobiliario(patrimonio.fundo, patrimonio));
              },
            ),
            TextButton(
              child: new Text("Excluir"),
              onPressed: () {
                pop(context);
                setState(() {
                  _controle.removerPatrimonio(index);
                });
              },
            ),
            TextButton(
              child: new Text("Cancelar"),
              onPressed: () {
                pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
