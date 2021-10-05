
//import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Localizador{
  static Future<LatLng?> obterLatitudeLongitudePorEndereco(String endereco) async{
    return null;
 /*   try{
      final query = endereco;

      var addresses = await Geocoder.local.findAddressesFromQuery(query).timeout(new Duration(seconds: 3));
      if(addresses == null) return null;
      var first = addresses.first;
      if (first == null) return null;
      else return LatLng(first.coordinates.latitude, first.coordinates.longitude);

    } catch(erro){
      return null;
    }
    */
  }
}