
import 'dart:io';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/gerenciadora_arquivo.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:flutter/material.dart';

import '../tela_ajuda.dart';
import '../tela_edicao_usuario.dart';
import '../tela_login.dart';

class MenuLateral extends StatelessWidget {
  late Usuario usuario;

  UserAccountsDrawerHeader _header(ImageProvider imageProvider) {
    return UserAccountsDrawerHeader(
      accountName: Text(usuario.nome!),
      accountEmail: Text(usuario.login!),
      currentAccountPicture: CircleAvatar(
        backgroundImage: imageProvider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Usuario>? future = Usuario.obter() as Future<Usuario>?;
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder: (context, snapshot) {
                usuario = snapshot.data!;
                if (usuario == null){
                  return Container();
                }
                else if (usuario.urlFoto != null){
                  Future<File> future_arquivo = GerenciadoraArquivo.obterImagem(usuario.urlFoto!);
                  return FutureBuilder<File>(
                    future: future_arquivo,
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      File? imagem = snapshot.data;
                      return _header(FileImage(imagem!));
                    }
                  );
                } else {
                  return _header(AssetImage("assets/icon/icone_aplicacao.png"));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Editar Dados do Usuário"),
              subtitle: Text("nome, login, senha ..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () async {
                // Fechando o menu lateral
                pop(context);

                push(context, TelaEdicaoUsuario(usuario));
              }
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("como usar"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Fechando o menu lateral
                pop(context);

                push(context, TelaAjuda());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Fechando o menu lateral
                pop(context);

                // Sobrescrevendo a tela de Login
                push(context, TelaLogin(), replace: true);

                // Retirando o usuário das Shared Preferences
                Usuario.limpar();
              },
            )
          ],
        ),
      ),
    );
  }
}
