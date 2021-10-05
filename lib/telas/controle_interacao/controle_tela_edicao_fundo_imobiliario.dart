
import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/fundo_imobiliario.dart';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:flutter/material.dart';

class ControleTelaEdicaoFundoImobiliario {
  FundoImobiliario? fundo;


  ControleTelaEdicaoFundoImobiliario(this.fundo);

  // Controlador de formulário (para fazer validações)
  final formkey = GlobalKey<FormState>();

  final controlador_sigla = TextEditingController();
  final controlador_nome = TextEditingController();

  // Controladores de foco
  final focus_nome = FocusNode();
  final focus_segmento = FocusNode();

  var segmento_selecionado;


  void inicializar_campos_edicao() {
    if(fundo == null){
      controlador_sigla.text = "";
      controlador_nome.text = "";
      segmento_selecionado = SegmentoFundoImobiliario.agencias_bancarias;
    } else {
      controlador_sigla.text = fundo!.sigla;
      controlador_nome.text = fundo!.nome;
      segmento_selecionado = fundo!.segmento;
    }
  }

  void atualizar_fundo_imobiliario() {
    // Se for uma inclusão
    if(fundo == null){
      fundo = FundoImobiliario(
        nome: controlador_nome.text,
        sigla: controlador_sigla.text,
        segmento: segmento_selecionado,
      );

      Future<Usuario?> future = Usuario.obter();
      future.then((Usuario? usuario) {
        if (usuario != null){
          FabricaControladora.obterPatrimonioControl().criarNovoPatrimonio(fundo!, usuario);
        }
      });


      // Se for uma atualização
    } else {
      fundo!.sigla = controlador_sigla.text;
      fundo!.nome = controlador_nome.text;
      fundo!.segmento = segmento_selecionado;

      FabricaControladora.obterFundoImobiliarioControl().atualizarFundoImobiliario(fundo!);
    }
  }

  void salvar_fundo_imobiliario(BuildContext context){
    if (formkey.currentState!.validate()){
      atualizar_fundo_imobiliario();
      Navigator.pop(context, "Salvou");
    }
  }

}