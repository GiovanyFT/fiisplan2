
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/persistencia/usuario_dao.dart';

Comparator<Usuario> usuarioPorNome= (u1, u2) => u1.nome!.compareTo(u2.nome!);

class UsuarioControl{
  UsuarioDAO _dao = UsuarioDAO();

  Future<Usuario?> obterUsuario(String login, String senha){
    return _dao.obter(login, senha);
  }

  void atualizarUsuario(Usuario usuario){
    _dao.atualizar(usuario);
  }

  Future<List<Usuario>> obterUsuarios() async{
    List<Usuario> usuarios = await _dao.obterLista();
    usuarios.sort(usuarioPorNome);
    return usuarios;
  }

  Future<int?> obterQuantidadeUsuarios() async{
    return await _dao.obterQuantidadeBase();
  }

  void removerUsuario(Usuario usuario) async {
    await _dao.excluir(usuario);
  }

  Future<int> inserirUsuario(Usuario usuario) async{
    return _dao.inserir(usuario);
  }

}