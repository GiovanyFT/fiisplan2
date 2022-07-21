import 'dart:io';


import 'package:firebase_storage/firebase_storage.dart';

import 'controle/fabrica_contoladora.dart';
import 'dominio/usuario.dart';

/* Para ver o dispositivo no Device File Explorer é necessário:
=> Verificar se o Google USB Driver está instalado (SDK Manager->SDK Tools)
=> Verificar se o Android SDK está configurado no Projeto (Project Struture->
Project SDK
 */

class DataBaseStorage {
  // Caminho em celulares reais
  static final String diretorio_imagens = "/data/data/app.fiisplan.fiisplan2/app_flutter/";
  static final String banco = "/data/data/app.fiisplan.fiisplan2/databases/fundos.db";

  static Future<List<File>> filesInDirectory(Directory dir) async {
    List<File> files = <File>[];
    await for (FileSystemEntity entity
        in dir.list(recursive: false, followLinks: false)) {
      FileSystemEntityType type = await FileSystemEntity.type(entity.path);
      if (type == FileSystemEntityType.file) {
        files.add(entity as File);
        print(entity.path);
      }
    }
    return files;
  }

  static void enviarBDParaStorage(String nome_arquivo) async {
    var storageRef = FirebaseStorage.instance.ref("/$nome_arquivo/");

    Reference storageReference = storageRef.child("$nome_arquivo.db");
    await storageReference.putFile(File(banco));

    Directory diretorio =
        Directory(diretorio_imagens);
    List<File> arquivos = await filesInDirectory(diretorio);
    storageRef = FirebaseStorage.instance.ref("/$nome_arquivo/imagens/");
    for (int i = 0; i < arquivos.length; i++) {
      // substring é utilizado para pegar o nome do arquivo de imagem
      // sem o restante do path
      storageReference = storageRef.child("${arquivos[i].path.substring(46)}");
      await storageReference.putFile(arquivos[i]);
    }
  }

  static Future<void> buscarBDDoStorage(String nome_arquivo) async {
    var storageRef = FirebaseStorage.instance.ref("/$nome_arquivo/");
    Reference storageReference = storageRef.child("$nome_arquivo.db");
    TaskSnapshot task = await storageReference.writeToFile(File(banco));


    task.ref.listAll().then((value) {
      Future<List<Usuario>> future = FabricaControladora.obterUsuarioControl()
          .obterUsuarios();
      future.then((usuarios) async {
        storageRef = FirebaseStorage.instance.ref("/$nome_arquivo/imagens/");
        for (Usuario usuario in usuarios) {
          if (usuario.urlFoto != null) {
            String nome_foto = "${usuario.urlFoto!}";
            String local_gravacao_imagem = "$diretorio_imagens${nome_foto.substring(48)}";
            storageReference = storageRef.child(nome_foto.substring(48));
            await storageReference.writeToFile(File(local_gravacao_imagem));
          }
        };
      });
    });
  }
}
