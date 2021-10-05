import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/dividendo.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/formatacao.dart';
import 'package:flutter/material.dart';

class ControleTelaEdicaoDividendo{
  Patrimonio patrimonio;
  Dividendo? dividendo = null;

  ControleTelaEdicaoDividendo(this.patrimonio);

  // Controlador de formulário (para fazer validações)
  final formkey = GlobalKey<FormState>();

  // Controladores de edição
  final controlador_data = TextEditingController();
  final controlador_valor = TextEditingController();

  // Controladores de foco
  final focus_valor = FocusNode();
  final focus_botao_salvar = FocusNode();

  void inicializar_campos_edicao() {
    controlador_data.text = "";
    controlador_valor.text = "";
  }

  void _inserir_dividendo() {
    dividendo = Dividendo(
        data: gerarDateTime(controlador_data.text)!,
        valor: double.parse(controlador_valor.text),
        patrimonio: patrimonio);

    FabricaControladora.obterDividendoControl().inserirDividendo(dividendo!);
  }

  void salvar_dividendo(BuildContext context) {
    if (formkey.currentState!.validate()) {
      _inserir_dividendo();
      Navigator.pop(context, "Salvou");
    }
  }
}