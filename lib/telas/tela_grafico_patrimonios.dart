import 'package:fiisplan2/dominio/patrimonio.dart';
import 'package:fiisplan2/util/widgets/grafico_pizza.dart';
import 'package:flutter/material.dart';


// Orientação da tela
import 'package:flutter/services.Dart';

import 'controle_interacao/controle_tela_grafico_patrimonios.dart';


class TelaGraficoPatrimonios extends StatefulWidget {
  List<Patrimonio> patrimonios;


  TelaGraficoPatrimonios(this.patrimonios);

  @override
  _TelaGraficoPatrimoniosState createState() => _TelaGraficoPatrimoniosState();
}

class _TelaGraficoPatrimoniosState extends State<TelaGraficoPatrimonios> {
  late ControleTelaGraficoPatrimonios _controle;

  @override
  void initState() {
    super.initState();

    // Bloqueando a orientação da tela para Retrato
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _controle = ControleTelaGraficoPatrimonios(widget.patrimonios , "Gráfico de Fundos");
  }

  @override
  void dispose() {
    super.dispose();

    // Desbloqueando a orientação da tela
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gráficos"),
      ),
      body: _body(),
    );
  }

  _body() {
    return GraficoPizza(_controle.labels, _controle.valores, _controle.titulo, 4);
  }
}
