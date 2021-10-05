import 'dart:convert';

import 'package:fiisplan2/util/prefs.dart';

import 'objeto.dart';

class TipoUsuario{
  static final String padrao = "Padrão";
  static final String administrador = "Administrador";
}


class Usuario extends Objeto{
  late String nome;
  late String tipo;
  late String login;
  late String senha;
  late String endereco;
  late String urlFoto;


  Usuario({required this.nome, required this.tipo, required this.login, required this.senha, required this.endereco, required this.urlFoto});


  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, tipo: $tipo, login: $login, senha: $senha, endereco: $endereco, urlFoto: $urlFoto}';
  }

  Usuario.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    nome = map["nome"];
    tipo = map["tipo"];
    login = map["login"];
    senha = map["senha"];
    endereco = map["endereco"];
    urlFoto = map["urlFoto"];
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;
    data['login'] = this.login;
    data['senha'] = this.senha;
    data['endereco'] = this.endereco;
    data['urlFoto'] = this.urlFoto;
    return data;
  }

  static void limpar(){
    // Limpando o usuário em Shared Preferences
    Prefs.setString("user.prefs", "");
  }

  // Salvando o usuário em Shared Preferences
  void salvar(){
    // Transformando o usuário em map
    Map usuario_map = this.toMap();

    // Transformando a map em String
    String usuario_string = json.encode(usuario_map);

    // Armazenando o usuário em Shared Preferences
    Prefs.setString("user.prefs", usuario_string);
  }

  static Future<Usuario?> obter() async{
    String usuario_string = await Prefs.getString("user.prefs");
    if (usuario_string.isEmpty){
      return null;
    }

    Map<String, dynamic> usuario_map = json.decode(usuario_string);

    Usuario usuario = Usuario.fromMap(usuario_map);
    return usuario;
  }

}