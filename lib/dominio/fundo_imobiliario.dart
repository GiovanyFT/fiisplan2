

import 'objeto.dart';

abstract class SegmentoFundoImobiliario{
  static final String agencias_bancarias = "Agências Bancárias";
  static final String educacional = "Educacional";
  static final String fundo_fundos = "Fundo de Fundos";
  static final String hospital = "Hospital";
  static final String hoteis = "Hotéis";
  static final String hibrido = "Híbrido";
  static final String incorporacao = "Incorporação";
  static final String lajes = "Lajes comerciais";
  static final String logistico = "Logístico";
  static final String recebiveis = "Recebíveis Imobiliários";
  static final String shopping = "Shopping";
  static final String outros = "Outros";
  static final String nd = "Não determinado";
  static final List<String> todos = [agencias_bancarias, educacional, fundo_fundos, hospital, hoteis, hibrido, incorporacao, lajes, logistico,
  recebiveis, shopping, outros, nd];
}

class FundoImobiliario extends Objeto{
  late String sigla;
  late String nome;
  late String segmento;

  FundoImobiliario({required this.sigla, required this.nome, required this.segmento});

  @override
  String toString() {
    return 'FundoImobiliario{sigla: $sigla, nome: $nome, segmento: $segmento}';
  }

  FundoImobiliario.fromMap(Map<String, dynamic> map) : super.fromMap(map){
    sigla = map["sigla"];
    nome = map["nome"];
    segmento = map["segmento"];
  }
}

