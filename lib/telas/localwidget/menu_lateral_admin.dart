import 'dart:io';

import 'package:fiisplan2/dominio/usuario.dart';
import 'package:flutter/material.dart';

import '../controle_interacao/controle_menu_lateral_admin.dart';


class MenuLateralAdmin extends StatefulWidget {
  const MenuLateralAdmin({Key? key}) : super(key: key);

  @override
  _MenuLateralAdminState createState() => _MenuLateralAdminState();
}

class _MenuLateralAdminState extends State<MenuLateralAdmin> {
  ControleMenuLateralAdmin _controle = ControleMenuLateralAdmin();

  @override
  void initState() {
    super.initState();
    _controle.inicializar();
  }

  UserAccountsDrawerHeader _header(ImageProvider imageProvider) {
    return UserAccountsDrawerHeader(
      accountName: Text(_controle.usuario!.nome!),
      accountEmail: Text(_controle.usuario!.login!),
      currentAccountPicture: CircleAvatar(
        backgroundImage: imageProvider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: Platform.isAndroid
              ? <Widget>[
            _cabecalho(_controle.future!),
            _ajuda(context),
            ExpansionTile(
                title: Text("Backup/Restore"),
                subtitle: Text('Salvamento/recuperação de dados'),
                children: <Widget>[
                  _backup(context),
                  _restore(context),
                ]
            ),
            _sair(context)
          ]
              : <Widget>[
            _cabecalho(_controle.future!),
            _ajuda(context),
            _sair(context),
          ],
        ),
      ),
    );
  }
  ListTile _sair(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text("Sair"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        _controle.sair(context);
      },
    );
  }

  ListTile _restore(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.restore),
      title: Text("Restore"),
      subtitle: Text("buscando o banco de dados na nuvem"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () async {
        _controle.restaurarBDFirebaseStorage(context);
      },
    );
  }

  ListTile _backup(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.backup),
      title: Text("Backup"),
      subtitle: Text("salvando o banco de dados na nuvem"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () async {
        _controle.salvarBDFirebaseStorage(context);
      },
    );
  }

  ListTile _ajuda(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.help),
      title: Text("Ajuda"),
      subtitle: Text("como usar"),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        _controle.irTelaAjuda(context);
      },
    );
  }

  FutureBuilder<Usuario> _cabecalho(Future<Usuario> future) {
    return FutureBuilder<Usuario>(
      future: future,
      builder: (context, snapshot) {
        _controle.usuario = snapshot.data;
        if (_controle.usuario == null) {
          return Container();
        } else if (_controle.usuario!.urlFoto != null) {
          return FutureBuilder<File>(
              future: _controle.future_arquivo,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                File? imagem = snapshot.data;
                return _header(FileImage(imagem!));
              });
        } else {
          return _header(AssetImage("assets/icon/icone_aplicacao.png"));
        }
      },
    );
  }
}

