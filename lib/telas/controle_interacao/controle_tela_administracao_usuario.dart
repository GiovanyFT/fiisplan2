
import 'dart:async';

import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/gerenciadora_arquivo.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:fiisplan2/util/toast.dart';
import 'package:flutter/material.dart';

import '../tela_edicao_usuario.dart';

class ControleTelaAdministracaoUsuario{
  final streamController = StreamController<List<Usuario>>();

  late List<Usuario> usuarios;

  Future<List<Usuario>> buscarUsuarios() async{
    usuarios = await FabricaControladora.obterUsuarioControl().obterUsuarios();
    streamController.add(usuarios);
    return usuarios;
  }

  void removerUsuario(int index) async{
    int? qt_patrimonios = await FabricaControladora.obterPatrimonioControl().obterQuantidadePatrimonios(usuarios[index]);
    if (qt_patrimonios! > 0){
      MensagemAlerta("Não é possível excluir o usuário (existem patrimônios vinculadoss a esse usuário) ");
    } else {
      Usuario? usuario_logado = await Usuario.obter();
      Usuario usuario_a_ser_excluido = usuarios[index];
      if(usuario_logado!.id == usuario_a_ser_excluido.id){
        MensagemAlerta("Não é possível excluir o usuário atualmente logado ");
      } else {
        Usuario usuario = usuarios.removeAt(index);
        if (usuario.urlFoto != null){
          GerenciadoraArquivo.excluirArquivo(usuario.urlFoto!);
        }
        FabricaControladora.obterUsuarioControl().removerUsuario(usuario);
        streamController.add(usuarios);
      }
    }
  }

  void irParaTelaEdicaoUsuario(BuildContext context, Usuario? usuario) async{
    String? s = await push(context, TelaEdicaoUsuario(usuario, auto_limpeza_imagem: false));
    // Se houve alguma atualização (se o usuário clica em Voltar, s chega com valor null)
    if (s != null){
      // buscarUsuarios é chamado para atualizar a listagem de Usuários
      // (na TelaEdicaoUsuario ocorreu alguma atualização que precisa ser refletida na listagem)
      buscarUsuarios().then((value) {
        // Se houve troca de imagem do usuário editado, o caminho desse arquivo virá em s.
        if (s != ""){
          // A exclusão do arquivo não pode ser feita em TelaEdicaoUsuario pois na volta para
          // TelaAdministracaoUsuario ocorre um disparo de exceção fazendo dessa forma.
          // Ao colocar a exclusão após a atualização da listagem de usuários, não fica faltando a imagem
          // antiga na volta a TelaAdministracaoUsuario e ela é apagada quando já não há problema (quando
          // a listagem já foi atualizada).
          GerenciadoraArquivo.excluirArquivo(s);
        }
      });
    }
  }
}