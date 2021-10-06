import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/gerenciadora_arquivo.dart';
import 'package:fiisplan2/util/widgets/botao.dart';
import 'package:fiisplan2/util/widgets/campo_edicao.dart';
import 'package:fiisplan2/util/widgets/seletor_opcoes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'controle_interacao/controle_tela_edicao_usuario.dart';

class TelaEdicaoUsuario extends StatefulWidget {
  Usuario usuario;

  TelaEdicaoUsuario(this.usuario);

  @override
  _TelaEdicaoUsuarioState createState() => _TelaEdicaoUsuarioState();
}

class _TelaEdicaoUsuarioState extends State<TelaEdicaoUsuario> {
  late ControleTelaEdicacaoUsuario _controle;

  @override
  void initState() {
    super.initState();
    _controle = ControleTelaEdicacaoUsuario(widget.usuario);
    _controle.inicializar();
  }

  @override
  void dispose() {
    super.dispose();
    _controle.streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edição de Usuário"),
      ),
      body: _body(),
    );
  }

  _body() {
    return StreamBuilder<Usuario>(
        stream: _controle.streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controle.usuario_logado = snapshot.data!;
          return _form();
        });
  }

  Form _form() {
    return Form(
      key: _controle.formkey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _imagem_botoes(),
              CampoEdicao(
                "Nome:",
                controlador: _controle.controlador_nome,
                recebedor_foco: _controle.focus_login,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicao(
                "Login:",
                controlador: _controle.controlador_login,
                marcador_foco: _controle.focus_login,
                recebedor_foco: _controle.focus_senha,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicao(
                "Senha: ",
                passaword: true,
                controlador: _controle.controlador_senha,
                marcador_foco: _controle.focus_senha,
                recebedor_foco: _controle.focus_endereco,
              ),
              SizedBox(
                height: 10,
              ),
              CampoEdicao(
                "Endereço: ",
                controlador: _controle.controlador_endereco,
                marcador_foco: _controle.focus_endereco,
                recebedor_foco: _controle.focus_botao_salvar,
              ),
              _SeletorTipoUsuario(),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Botao(
                      texto: "Salvar",
                      cor: Colors.green,
                      ao_clicar: () {
                        _controle.salvar_usuario(context);
                      },
                      marcador_foco: _controle.focus_botao_salvar,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Botao(
                      texto: "Cancelar",
                      cor: Colors.green,
                      ao_clicar: () {
                        _controle.inicializar();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _imagem_botoes() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: 16),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _controle.imagem != null
              ? Image.file(
                  _controle.imagem!,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/icon/icone_aplicacao.png",
                  fit: BoxFit.contain,
                ),
          Container(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "BotaoCamera",
                  onPressed: () async {
                    var image =
                        await ImagePicker().pickImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        _controle.imagem = GerenciadoraArquivo.XFileToFile(image);
                      });
                    }
                  },
                  child: Icon(Icons.photo_camera),
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  heroTag: "BotaoGaleria",
                  onPressed: () async {
                    var image = await ImagePicker().pickImage(
                        source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _controle.imagem = GerenciadoraArquivo.XFileToFile(image);
                      });
                    }
                  },
                  child: Icon(Icons.photo),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _SeletorTipoUsuario() {
    if (_controle.usuario_logado.tipo == TipoUsuario.padrao)
      return _sized_box();
    else
      return _seletor();
  }

  _seletor() {
    return Column(
      children: <Widget>[
        _sized_box(),
        SeletorOpcoes(
          opcoes: [TipoUsuario.administrador, TipoUsuario.padrao],
          valor_selecionado: _controle.tipo_usuario_selecionado,
          ao_mudar_opcao: (String novoItemSelecionado) {
            _controle.tipo_usuario_selecionado = novoItemSelecionado;
          },
        ),
        _sized_box(),
      ],
    );
  }

  _sized_box() {
    return SizedBox(
      height: 10,
    );
  }
}
