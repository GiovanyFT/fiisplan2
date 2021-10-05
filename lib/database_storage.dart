import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'controle/fabrica_contoladora.dart';
import 'dominio/usuario.dart';


class DataBaseStorage {
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
    await storageReference.putFile(File(
        "/data/data/com.fundos.fundosimobiliarios/databases/fundos.db"));
    String urlFile = await storageReference.getDownloadURL();
    print("urlFile1 => $urlFile");

    Directory diretorio =
        Directory("/data/data/com.fundos.fundosimobiliarios/app_flutter/");
    List<File> arquivos = await filesInDirectory(diretorio);
    storageRef = FirebaseStorage.instance.ref("/$nome_arquivo/imagens/");
    for (int i = 0; i < arquivos.length; i++) {
      storageReference = storageRef.child("${arquivos[i].path.substring(52)}");
      await storageReference.putFile(arquivos[i]);
      urlFile = await storageReference.getDownloadURL();
      print("arquivo$i => $urlFile");
    }
  }

  static Future<void> buscarBDDoStorage(String nome_arquivo) async {
    var storageRef = FirebaseStorage.instance.ref("/$nome_arquivo/");
    Reference storageReference = storageRef.child("$nome_arquivo.db");
    DownloadTask task = (await storageReference.writeToFile(
        File("/data/data/com.fundos.fundosimobiliarios/databases/fundos.db"))) as DownloadTask;

    task.whenComplete(() {
      Future<List<Usuario>> future = FabricaControladora.obterUsuarioControl()
          .obterUsuarios();
      future.then((usuarios) async {
        storageRef = FirebaseStorage.instance.ref("/$nome_arquivo/imagens/");
        for (Usuario usuario in usuarios) {
          if (usuario.urlFoto != null) {
            String nome_foto = "${usuario.urlFoto!.substring(55)}";
            storageReference = storageRef.child(nome_foto);
            await storageReference.writeToFile(File(usuario.urlFoto!));
          }
        };
      });
    });
  }
}
