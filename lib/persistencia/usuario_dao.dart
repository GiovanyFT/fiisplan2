
import 'package:fiisplan2/dominio/usuario.dart';

import 'base_dao.dart';

class UsuarioDAO extends BaseDAO<Usuario> {
  List<String> colunas = ["nome", "tipo", "login", "senha", "endereco", "urlfoto"];

  @override
  String get nomeTabela => "USUARIO";


  @override
  Usuario fromMap(Map<String, dynamic> map) {
    return Usuario.fromMap(map);
  }

  void atualizar(Usuario usuario) async{
    this.atualizarBase(
        colunas : this.colunas,
        nomes_filtros : ["id"],
        valores : [ usuario.nome, usuario.tipo, usuario.login, usuario.senha, usuario.endereco,
        usuario.urlFoto, usuario.id]
    );
  }

  Future<Usuario?>  obter(String login, String senha) async{
    List<Usuario> usuarios = await this.obterListaBase(
        nomes_filtros : ["login", "senha"],
        valores : [login, senha]);
    if(usuarios.length > 0)
      return usuarios[0];
    return null;
  }

  Future<List<Usuario>> obterLista() async{
    return await this.obterListaBase();
  }

  Future<int> excluir(Usuario usuario) async {
    return this.excluirBase(
      nomes_filtros: ["id"],
      valores: [usuario.id],
    );
  }

  Future<int> inserir(Usuario usuario) async{
    return this.inserirBase(
      colunas : this.colunas,
      valores: [ usuario.nome, usuario.tipo, usuario.login, usuario.senha, usuario.endereco,
        usuario.urlFoto]);
  }
}