
import 'dart:async';
import 'dart:io';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/gerenciadora_arquivo.dart';
import 'package:flutter/material.dart';


class ControleTelaEdicacaoUsuario {
  final streamController = StreamController<Usuario>();
  Usuario usuario;
  late Usuario usuario_logado;

  ControleTelaEdicacaoUsuario(this.usuario);

  // Controlador de formulário (para fazer validações)
  final formkey = GlobalKey<FormState>();

  // Controladores dos campos de edição
  final controlador_nome = TextEditingController();
  final controlador_login = TextEditingController();
  final controlador_senha = TextEditingController();
  final controlador_endereco = TextEditingController();

  // Valor selecionado no Seletor de Opções
  String? tipo_usuario_selecionado;

  // Controladores de foco
  final focus_login = FocusNode();
  final focus_senha = FocusNode();
  final focus_endereco = FocusNode();
  final focus_botao_salvar = FocusNode();

  // Arquivo de imagem
  late File imagem;

  void inicializar() async{
    usuario_logado = (await Usuario.obter())!;
    streamController.add(usuario_logado);

    if(usuario != null) {
      controlador_nome.text = usuario.nome;
      controlador_login.text = usuario.login;
      controlador_senha.text = usuario.senha;
      controlador_endereco.text = usuario.endereco;
      tipo_usuario_selecionado = usuario.tipo;
      if (usuario.urlFoto != null){
        imagem = await GerenciadoraArquivo.obterImagem(usuario.urlFoto);
      }
    } else {
      // Se é usuário novo
      tipo_usuario_selecionado = TipoUsuario.padrao;
    }
  }

  Future<bool> atualizar_usuario(BuildContext context) async{
    if(usuario != null){
      usuario.nome = controlador_nome.text;
      usuario.login = controlador_login.text;
      usuario.senha = controlador_senha.text;
      usuario.endereco = controlador_endereco.text;
      usuario.tipo = tipo_usuario_selecionado!;
      if(imagem != null){
        // Se já havia foto pode ser necessário apagá-la
        if (usuario.urlFoto != null){
          // Se houve troca de foto
          if (imagem.path != usuario.urlFoto){
            GerenciadoraArquivo.excluirArquivo(usuario.urlFoto);
            usuario.urlFoto = await GerenciadoraArquivo.salvarImagem(imagem);
          }
          // Se não havia foto é necessário salvá-la
        } else {
          usuario.urlFoto = await GerenciadoraArquivo.salvarImagem(imagem);
        }
      }
      // Se o usuário logado é o que está sendo salvo
      // atualizamos as Shared Preferences
      if(usuario_logado.id == usuario.id) {
        usuario.salvar();
      }
      FabricaControladora.obterUsuarioControl().atualizarUsuario(usuario);
    } else {
      Usuario usuario_novo = Usuario(
        nome: controlador_nome.text,
        login: controlador_login.text,
        senha:  controlador_senha.text,
        endereco: controlador_endereco.text,
        tipo: tipo_usuario_selecionado!, urlFoto: '',
      );
      if(imagem != null){
        usuario_novo.urlFoto = await GerenciadoraArquivo.salvarImagem(imagem);
      }
      FabricaControladora.obterUsuarioControl().inserirUsuario(usuario_novo);
    }
    return true;
  }

  void salvar_usuario(BuildContext context){
    if (formkey.currentState!.validate()) {
      Future future = atualizar_usuario(context);
      future.then((value){
        Navigator.pop(context, "Salvou");
      });
    }
  }
}