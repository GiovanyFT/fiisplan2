import 'package:intl/intl.dart';

String formatarDateTime(DateTime datatime){
  String mes;
  if (datatime.month >= 10)
    mes = datatime.month.toString();
  else
    mes = "0${datatime.month.toString()}";
  String dia;
  if(datatime.day >= 10)
    dia = datatime.day.toString();
  else
    dia = "0${datatime.day.toString()}";
  String ano = datatime.year.toString();
  String data = "$dia/$mes/$ano";
  return data;
}

DateTime? gerarDateTime(String data){
  try{
    if (data.length != 10) // dd/mm/aaaa
      return null;
    String dia = data.substring(0,2);
    String mes = data.substring(3,5);
    String ano = data.substring(6);
    String data_formatada = "$ano-$mes-$dia";
    return DateTime.parse(data_formatada);
  } on Exception {
    return null;
  }
}

String formatarNumero(double numero){
  NumberFormat formatter = NumberFormat("###,###,###,###,###,###,##0.00");
  String valor  = formatter.format(numero);
  int indice = valor.indexOf(".");
  String s_aux = valor.substring(0, indice);
  s_aux = s_aux.replaceAll(",", ".");
  s_aux = s_aux + ",";
  valor = s_aux + valor.substring(indice+1);
  return valor;
}

