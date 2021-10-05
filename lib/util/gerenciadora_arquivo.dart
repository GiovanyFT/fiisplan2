import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GerenciadoraArquivo {

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> salvarImagem(File arquivo) async{
    DateTime dataTime = DateTime.now();
    String nome_arquivo = dataTime.millisecondsSinceEpoch.toString();
    final path = await _localPath;
    await arquivo.copy('$path/$nome_arquivo.png');
    return '$path/$nome_arquivo.png';
  }

  static Future<File> obterImagem(String path)async {
    return File(path);
  }

  static void excluirArquivo(String path) async {
    File(path).delete(recursive: true);
  }

}