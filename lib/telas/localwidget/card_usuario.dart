import 'dart:io';

import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/gerenciadora_arquivo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardUsuario extends StatelessWidget {
  Usuario usuario;

  CardUsuario(this.usuario);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: usuario.urlFoto == null
                ? Image.asset("assets/icon/icone_aplicacao.png",
                    fit: BoxFit.contain)
                : _obterImagem(usuario.urlFoto),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 25,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                color: Colors.green,
              ),
              padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      usuario.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        // Sem linha abaixo do texto
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _obterImagem(String urlFoto) {
    Future<File> future = GerenciadoraArquivo.obterImagem(urlFoto);
    return FutureBuilder<File>(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        File? imagem = snapshot.data;
        return Image.file(imagem!, fit: BoxFit.cover );
      }
    );
  }
}
