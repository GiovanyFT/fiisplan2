import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Localizador{
  static Future<LatLng?> obterLatitudeLongitudePorEndereco(String endereco) async{

    List<Location> locations = await locationFromAddress(endereco);
    if((locations == null) || (locations.first == null)) return null;
    else
      return LatLng(locations.first.latitude, locations.first.longitude);
  }
}