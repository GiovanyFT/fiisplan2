import 'package:fiisplan2/controle/fabrica_contoladora.dart';
import 'package:fiisplan2/dominio/compra.dart';
import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/formatacao.dart';
import 'package:flutter/material.dart';

class ControleTelaEdicaoCompra {
  Patrimonio patrimonio;
  Compra? compra = null;

  ControleTelaEdicaoCompra(this.patrimonio);

  // Controlador de formulário (para fazer validações)
  final formkey = GlobalKey<FormState>();

  // Controladores de edição
  final controlador_data_compra = TextEditingController();
  final controlador_valor_cota = TextEditingController();
  final controlador_quantidade_cotas = TextEditingController();
  final controlador_taxas = TextEditingController();

  // Controladores de foco
  final focus_valor_cota = FocusNode();
  final focus_quantidade_cotas = FocusNode();
  final focus_taxas = FocusNode();
  final focus_botao_salvar = FocusNode();

  void inicializar_campos_edicao() {
    controlador_data_compra.text = "";
    controlador_valor_cota.text = "";
    controlador_quantidade_cotas.text = "";
    controlador_taxas.text = "";
  }

   String? validarTaxas(String text) {
    if (text.isEmpty) {
      return "O campo 'Taxas' está vazio e necessita ser preenchido";
    }
    try {
      double valor = double.parse(text);
      if (valor < 0) {
        return "O valor digitado deve ser maior ou igual 0";
      }
    } on Exception {
      return "O valor DEVE ser um número real (use o separador '.' para os centavos)";
    }
    return null;
  }

  void _inserir_compra() {
    compra = Compra(
        data_transacao: gerarDateTime(controlador_data_compra.text)!,
        valor_cota: double.parse(controlador_valor_cota.text),
        quantidade: int.parse(controlador_quantidade_cotas.text),
        taxa: double.parse(controlador_taxas.text),
        patrimonio: patrimonio);

    FabricaControladora.obterCompraControl().inserirCompra(compra!);
  }

  void salvar_compra(BuildContext context) {
    if (formkey.currentState!.validate()) {
      _inserir_compra();
      Navigator.pop(context, "Salvou");
    }
  }
}
