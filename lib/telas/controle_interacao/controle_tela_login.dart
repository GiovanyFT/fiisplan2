
import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:fiisplan2/util/toast.dart';
import 'package:flutter/material.dart';

import '../tela_administracao_usuario.dart';
import '../tela_principal.dart';

class ControleTelaLogin {
  // Controles de edição do login e senha
  final controlador_login = TextEditingController();
  final controlador_senha = TextEditingController();

  // Controlador de formulário (para fazer validações)
  final formkey = GlobalKey<FormState>();

  // Controladores de foco
  final focus_senha = FocusNode();
  final focus_botao = FocusNode();

  void logar(BuildContext context) async{
    if (formkey.currentState!.validate()){
      String login = controlador_login.text.trim();
      String senha = controlador_senha.text.trim();
      Usuario? usuario = await FabricaControladora.obterUsuarioControl().obterUsuario(login, senha);
      if(usuario != null){
        // Guarando em Shared Preferences
        usuario.salvar();
        if (usuario.tipo == TipoUsuario.padrao){
          push(context, TelaPrincipal(usuario), replace:  true);
        } else {
          push(context, TelaAdministracaoUsuario(), replace:  true);
        }
      } else {
        MensagemErro(context, "Login ou senha inválidos!!");
      }
    }
  }
}