
import 'dart:async';
import 'dart:io';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/gerenciadora_arquivo.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:flutter/material.dart';


class ControleTelaEdicacaoUsuario {
  final streamController = StreamController<Usuario>();
  Usuario? usuario;
  bool auto_limpeza_imagem;
  late Usuario usuario_logado;


  ControleTelaEdicacaoUsuario(this.usuario, this.auto_limpeza_imagem);

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
  File? imagem;

  void inicializar() async{
    usuario_logado = (await Usuario.obter())!;
    streamController.add(usuario_logado);

    if(usuario != null) {
      controlador_nome.text = usuario!.nome!;
      controlador_login.text = usuario!.login!;
      controlador_senha.text = usuario!.senha!;
      controlador_endereco.text = usuario!.endereco!;
      tipo_usuario_selecionado = usuario!.tipo;
      if (usuario!.urlFoto != null){
        imagem = await GerenciadoraArquivo.obterImagem(usuario!.urlFoto!);
      }
    } else {
      // Se é usuário novo
      tipo_usuario_selecionado = TipoUsuario.padrao;
    }
  }

  Future<String> atualizar_usuario(BuildContext context) async{
    String s = "";
    if(usuario != null){
      usuario!.nome = controlador_nome.text;
      usuario!.login = controlador_login.text;
      usuario!.senha = controlador_senha.text;
      usuario!.endereco = controlador_endereco.text;
      usuario!.tipo = tipo_usuario_selecionado!;
      if(imagem != null){
        // Se já havia foto pode ser necessário apagá-la
        if (usuario!.urlFoto != null){
          // Se houve troca de foto
          if (imagem!.path != usuario!.urlFoto){
            if (auto_limpeza_imagem){
              // Excluíndo a arquivo antigo
              print("Auto limpeza acionado");
              GerenciadoraArquivo.excluirArquivo(usuario!.urlFoto!);
            } else {
              print("Gravei o caminho");
              // Guarando o caminho da foto antiga para futura exclusão
              s = usuario!.urlFoto!;
            }
            usuario!.urlFoto = await GerenciadoraArquivo.salvarImagem(imagem!);
          }
          // Se não havia foto é necessário salvá-la
        } else {
          usuario!.urlFoto = await GerenciadoraArquivo.salvarImagem(imagem!);
        }
      }
      // Se o usuário logado é o que está sendo salvo
      // atualizamos as Shared Preferences
      if(usuario_logado.id == usuario!.id) {
        usuario!.salvar();
      }
      FabricaControladora.obterUsuarioControl().atualizarUsuario(usuario!);
    } else {
      Usuario usuario_novo = Usuario(
        nome: controlador_nome.text,
        login: controlador_login.text,
        senha:  controlador_senha.text,
        endereco: controlador_endereco.text,
        tipo: tipo_usuario_selecionado!,
        urlFoto: null,
      );
      if(imagem != null){
        usuario_novo.urlFoto = await GerenciadoraArquivo.salvarImagem(imagem!);
      }
      FabricaControladora.obterUsuarioControl().inserirUsuario(usuario_novo);
    }
    return s;
  }

  void salvar_usuario(BuildContext context){
    if (formkey.currentState!.validate()) {
      // A função atualizar_usuario retorna "" se não houve troca da imagem
      // do usuário e retorna o caminho da imagem a ser excluída caso contrário
      Future future = atualizar_usuario(context);
      future.then((value){
        pop(context, mensagem: value);
      });
    }
  }
}