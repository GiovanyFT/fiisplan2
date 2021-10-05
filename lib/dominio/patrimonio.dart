
import 'package:fiisplan2/dominio/usuario.dart';

import 'fundo_imobiliario.dart';
import 'objeto.dart';

Comparator<Patrimonio> patrimonioPorSiglaFundo = (p1, p2) => p1.fundo.sigla.compareTo(p2.fundo.sigla);
Comparator<Patrimonio> patrimonioPorSiglaFundoDesc = (p1, p2) => p2.fundo.sigla.compareTo(p1.fundo.sigla);

Comparator<Patrimonio> patrimonioPorNomeFundo = (p1, p2) => p1.fundo.nome.compareTo(p2.fundo.nome);
Comparator<Patrimonio> patrimonioPorNomeFundoDesc = (p1, p2) => p2.fundo.nome.compareTo(p1.fundo.nome);

Comparator<Patrimonio> patrimonioPorTipoFundo = (p1, p2) => p1.fundo.segmento.compareTo(p2.fundo.segmento);
Comparator<Patrimonio> patrimonioPorTipoFundoDesc = (p1, p2) => p2.fundo.segmento.compareTo(p1.fundo.segmento);

Comparator<Patrimonio> patrimonioPorValorMedioFundo = (p1, p2) => p1.valor_medio.compareTo(p2.valor_medio);
Comparator<Patrimonio> patrimonioPorValorMedioFundoDesc = (p1, p2) => p2.valor_medio.compareTo(p1.valor_medio);

Comparator<Patrimonio> patrimonioPorQtCotaFundo = (p1, p2) => p1.qt_cotas.compareTo(p2.qt_cotas);
Comparator<Patrimonio> patrimonioPorQtCotaFundoDesc = (p1, p2) => p2.qt_cotas.compareTo(p1.qt_cotas);

class Patrimonio extends Objeto{
  late FundoImobiliario fundo;
  late Usuario usuario;
  late double valor_medio;
  late int qt_cotas;

  Patrimonio({required this.fundo, required this.usuario, required this.valor_medio,
      required this.qt_cotas});

  @override
  String toString() {
    return 'Patrimonio{id: $id, fundo: $fundo, usuario: $usuario, '
        'valor_medio: $valor_medio, qt_cotas: $qt_cotas}';
  }

  Patrimonio.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    valor_medio = map["valor_medio"];
    qt_cotas = map["qt_cotas"];
    fundo = FundoImobiliario.fromMap(map);
  }
}
