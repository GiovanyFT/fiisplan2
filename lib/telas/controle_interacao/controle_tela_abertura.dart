
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/persistencia/db_helper.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:flutter/cupertino.dart';

import '../tela_administracao_usuario.dart';
import '../tela_login.dart';
import '../tela_principal.dart';

class ControleTelaAbertura{
  void inicializarAplicacao(BuildContext context) {

    // Inicializando o banco
    Future futureA = DatabaseHelper().db;

    // Dando um tempo para exibição da tela de abertura
    Future futureB = Future.delayed(Duration(seconds: 3));

    // Obtendo o usuário logado (se houver)
    Future<Usuario?>  futureC = Usuario.obter();

    // Aguardando as 3 operações terminarem
    // Quando terminarem a aplicação ou vai para a tela de login
    // ou para a tela principal
    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario? usuario = values[2];

      if(usuario != null){
        if (usuario.tipo == TipoUsuario.padrao) {
          push(context, TelaPrincipal(usuario), replace: true);
        } else {
          push(context, TelaAdministracaoUsuario(), replace: true);
        }
      } else {
        push(context, TelaLogin(), replace: true);
      }
    });
  }
}
