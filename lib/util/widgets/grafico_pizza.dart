import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../formatacao.dart';

class GraficoPizza extends StatefulWidget {
  List<String> labels;
  List<double> valores;
  String titulo;
  int qt_indicator_linha;

  GraficoPizza(this.labels, this.valores, this.titulo, this.qt_indicator_linha);

  @override
  _GraficoPizzaState createState() => _GraficoPizzaState();
}

class _GraficoPizzaState extends State<GraficoPizza> {
  final List<Color> _colors = [
    const Color(0xff0293ee),
    const Color(0xfff8b250),
    const Color(0xff845bef),
    const Color(0xff13d38e),
    const Color(0xff800000),
    const Color(0xfff08080),
    const Color(0xffffd700),
    const Color(0xff8b4513),
    const Color(0xff808000),
    const Color(0xffff0000),
    const Color(0xff00FFFF),
    const Color(0xffDC143C),
    const Color(0xff0000CD),
    const Color(0xffD2691E),
    const Color(0xffEEE8AA),
    const Color(0xffFF00FF),
  ];

  late int touchedIndex;
  late double valor_total;

  late String _item;
  late String _porcentagem;
  late String _valor;

  _gerarIndicators(int indice_inicial, int quantidade) {
    List<Container> indicators = <Container>[];
    int indice_final = indice_inicial + quantidade;
    for (int i = indice_inicial; i < indice_final; i++) {
      Indicator indicator = Indicator(
        color: _colors[i],
        text: widget.labels[i],
        isSquare: false,
        size: touchedIndex == i ? 20 : 18,
        textColor: touchedIndex == i ? Colors.black : Colors.grey,
      );
      GestureDetector gestureDetector = GestureDetector(
          onTap: (){
            setState(() {
              touchedIndex = i;
              _atualizarCaixaTexto();
            });
          },
          child: indicator,
      );
      Container container = Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: gestureDetector,
      );
      indicators.add(container);
    }
    return indicators;
  }

  void _atualizarCaixaTexto() {
    _item = widget.labels[touchedIndex];
    _porcentagem = ((widget.valores[touchedIndex] / valor_total) * 100).toStringAsFixed(2) + "%";
    _valor = formatarNumero(widget.valores[touchedIndex]);
  }

  _gerarColunaLabels() {
    int qt_itens = widget.labels.length;
    int qt_linhas = (qt_itens / widget.qt_indicator_linha).ceil();
    int qt_linhas_completas = (qt_itens / widget.qt_indicator_linha).floor();
    List<Widget> linhas = <Widget>[];
    for (int i = 0; i < qt_linhas; i++) {
      int qt_labels;
      if (i < qt_linhas_completas)
        qt_labels = widget.qt_indicator_linha;
      else {
        qt_labels = qt_itens - qt_linhas_completas * widget.qt_indicator_linha;
      }
      Row linha = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: _gerarIndicators(i * widget.qt_indicator_linha, qt_labels),
      );
      SingleChildScrollView scrollView = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: linha,
      );
      linhas.add(scrollView);
      linhas.add(SizedBox(
        height: 30,
      ));
    }
    print("As linhas $linhas");
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: linhas,
    );
  }

  double _obterAspectRatio(){
    double aspectRatio = MediaQuery.of(context).size.aspectRatio * 1.2;
    return aspectRatio;
  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = _obterAspectRatio();

    if(widget.valores.length > 16){
      return Center(
        child: Text(
            "Gráfico Pizza suporta no máximo 16 itens",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
        ),
      );
    }
    valor_total = _calcularValorTotal();
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                widget.titulo,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff000000),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            _gerarColunaLabels(),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    _item = "";
                                    _porcentagem = "";
                                    _valor = "";
                                  }else {
                                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                    _atualizarCaixaTexto();
                                  }
                              });
                          }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 12,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    color: Colors.black26, style: BorderStyle.solid, width: 1.50),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      _item != null ? "Item: ${_item}": "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      _porcentagem != null ? "Porcentagem: ${_porcentagem}": "",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      _valor != null ? "Valor: ${_valor}": "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      widget.valores.length,
          (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 18 : 14;
        final double radius = isTouched ? 150 : 120;
        final double opacity = isTouched ? 1 : 0.6;

        return PieChartSectionData(
          color: _colors[i].withOpacity(opacity),
          value: (widget.valores[i] / valor_total),
          title: '${((widget.valores[i] / valor_total) * 100).toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xff000000)),
          titlePositionPercentageOffset: 0.55,
        );
      },
    );
  }

  double _calcularValorTotal() {
    double valor_total = 0;
    int qt_itens = widget.valores.length;
    for (int i = 0; i < qt_itens; i++)
      valor_total += widget.valores[i];
    return valor_total;
  }
}


class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}