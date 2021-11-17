import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Localizador{
  static Future<LatLng?> obterLatitudeLongitudePorEndereco(String endereco) async{

    try{
      List<Location> locations = await locationFromAddress(endereco);
      if((locations == null) || (locations.first == null)) return null;
      else
        return LatLng(locations.first.latitude, locations.first.longitude);
    } on NoResultFoundException {
      print("Endereço não encontrado");
      return null;
    } on Exception catch (e) {
      print("Erro desconhecido: $e");
      return null;
    }
  }
}