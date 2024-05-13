import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import '../formatacao.dart';
import 'botao_icone.dart';


class CampoEdicaoData extends StatefulWidget {
  final String texto_label;
  final String texto_dica;
  final bool  passaword;
  final TextEditingController? controlador;
  late FormFieldValidator<String> validador;
  final TextInputType teclado;
  final FocusNode? marcador_foco;
  final FocusNode? recebedor_foco;

  CampoEdicaoData(
      this.texto_label,
      {this.texto_dica = "",
        this.passaword = false,
        this.controlador = null,
        this.teclado = TextInputType.text,
        this.marcador_foco = null,
        this.recebedor_foco = null}){
      this.validador = (String? text){
        if(text!.isEmpty)
          return "O campo '$texto_label' está vazio e necessita ser preenchido";
        if(gerarDateTime(text) == null) {
           return "Formato de data inválido (deve ser dd/mm/aaaa)";
        }
        return null;
      };
    }

  @override
  _CampoEdicaoDataState createState() => _CampoEdicaoDataState();
}

class _CampoEdicaoDataState extends State<CampoEdicaoData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: TextFormField(
            enabled: false,
            validator: widget.validador,
            obscureText: widget.passaword,
            controller: widget.controlador,
            keyboardType: widget.teclado,
            textInputAction: TextInputAction.next,
            focusNode: widget.marcador_foco,
            onFieldSubmitted:(String text){
              FocusScope.of(context).requestFocus(widget.recebedor_foco);
            },
            // Estilo da fonte
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: widget.texto_label,
              // Estilo de labelText
              labelStyle: TextStyle(
                fontSize: 25,
                color: Colors.grey,
              ),
              hintText: widget.texto_dica,
              // Estilo do hintText
              hintStyle: TextStyle(
                fontSize: 10,
                color: Colors.green,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 1,
          child: BotaoIcone(
            ao_clicar: () async {
              DateTime? datatime = await showRoundedDatePicker(
                  context: context,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.green,
                      primary: Colors.green,
                    ),
                  ),
              );
              setState(() {
                widget.controlador!.text = formatarDateTime(datatime!);
              });
            },
            cor: Colors.green,
            icone: Icons.calendar_today,
          ),
        ),
      ],
    );
  }
}
