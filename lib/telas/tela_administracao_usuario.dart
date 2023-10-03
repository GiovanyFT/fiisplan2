import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/telas/tela_mapa_usuarios.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'controle_interacao/controle_tela_administracao_usuario.dart';
import 'localwidget/card_usuario.dart';
import 'localwidget/menu_lateral_admin.dart';

class TelaAdministracaoUsuario extends StatefulWidget {


  @override
  _TelaAdministracaoUsuarioState createState() => _TelaAdministracaoUsuarioState();
}

class _TelaAdministracaoUsuarioState extends State<TelaAdministracaoUsuario>{
  late ControleTelaAdministracaoUsuario _controle;

  @override
  void initState() {
    super.initState();
    _controle = ControleTelaAdministracaoUsuario(this.context);
    _controle.buscarUsuarios();
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
        title: Text("Administração de Usuários"),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.mapLocation,
            ),
            onPressed: () {
              push(context, TelaMapaUsuarios(_controle.usuarios));
            },
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controle.irParaTelaEdicaoUsuario(context, null);
        },
      ),
      drawer: MenuLateralAdmin(),
    );
  }

  _body() {
    return StreamBuilder<List<Usuario>>(
        stream: _controle.streamController.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controle.usuarios = snapshot.data!;
          return _gridView();
        }
    );
  }

  _gridView() {
    return Container(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _controle.usuarios.length,
        itemBuilder: (context, index) {
          Usuario usuario = _controle.usuarios[index];
          return GestureDetector(
            onTap: (){
              _showDialog(index, usuario);
            },
            child: CardUsuario(usuario),
          );
        },
      ),
    );
  }

  void _showDialog(int index, usuario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Edição de Usuário"),
          content: new Text(
              "O que você deseja fazer com esse usuário?"),
          actions: <Widget>[
            // define os botões na base do dialogo
            TextButton(
              child: new Text("Alterar"),
              onPressed: () async {
                pop(context);
                _controle.irParaTelaEdicaoUsuario(context, usuario);
              },
            ),
            TextButton(
              child: new Text("Excluir"),
              onPressed: () {
                pop(context);
                _controle.removerUsuario(index);
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
