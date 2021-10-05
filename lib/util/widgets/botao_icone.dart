import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotaoIcone extends StatelessWidget {
  String texto;
  VoidCallback? ao_clicar;
  FocusNode? marcador_foco;
  Color? cor;
  bool mostrar_progress;
  IconData? icone;

  BotaoIcone(
      {this.texto = "",
      this.ao_clicar,
      this.marcador_foco,
      this.cor,
      this.mostrar_progress = false,
      this.icone = null});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: this.cor,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
        ),
        child: mostrar_progress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : icone != null
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(icone),
                        Text(
                          texto,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    texto,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
        onPressed: ao_clicar,
        focusNode: marcador_foco,
      ),
    );
  }
}
