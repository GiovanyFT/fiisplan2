
import 'package:flutter/cupertino.dart';

import '../../database_storage.dart';
import '../../dominio/usuario.dart';
import 'dart:io';

import '../../util/gerenciadora_arquivo.dart';
import '../../util/nav.dart';
import '../../util/toast.dart';
import '../tela_ajuda.dart';
import '../tela_login.dart';

class ControleMenuLateralAdmin {
  Usuario? usuario;
  Future<Usuario>? future;
  Future<File>? future_arquivo;

  void inicializar() {
    future = Usuario.obterNaoNulo();
    future!.then((usuario){
      if (usuario.urlFoto != null)
        future_arquivo = GerenciadoraArquivo.obterImagem(usuario.urlFoto!);
    });
  }

  void restaurarBDFirebaseStorage(BuildContext context) async {
    // Obtendo o banco de dados da nuvem
    bool buscou_bd = await DataBaseStorage.buscarBDDoStorage(this.usuario!.login!);
    if(buscou_bd){
      // Fechando o menu lateral
      pop(context);

      // Sobrescrevendo a tela de Login
      push(context, TelaLogin(), replace: true);

      // Retirando o usuário das Shared Preferences
      Usuario.limpar();
    } else{
      MensagemErro(context, "Erro na obtenção do banco no Firebase Storage");
    }
  }

  void salvarBDFirebaseStorage(BuildContext context) {
    // Fechando o menu lateral
    pop(context);

    // Salvando o banco de dados na nuvem
    DataBaseStorage.enviarBDParaStorage(this.usuario!.login!);
    MensagemSucesso(context, "Backup executado com sucesso!!!");
  }

  void irTelaAjuda(BuildContext context) {
    // Fechando o menu lateral
    pop(context);

    push(context, TelaAjuda());
  }

  void sair(BuildContext context) {
    // Fechando o menu lateral
    pop(context);

    // Sobrescrevendo a tela de Login
    push(context, TelaLogin(), replace: true);

    // Retirando o usuário das Shared Preferences
    Usuario.limpar();

  }
}