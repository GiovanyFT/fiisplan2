import 'dart:async';
import 'dart:io';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:fiisplan2/util/gerador_bitmapdescriptor.dart';
import 'package:fiisplan2/util/gerenciadora_arquivo.dart';
import 'package:fiisplan2/util/localizador.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ControleTelaMapaUsuarios{
  List<Usuario> usuarios;
  Set<Marker>? markers;
  GoogleMapController? mapController;

  Marker? marker_atual;
  int posicao_marker_atual = -1;

  ControleTelaMapaUsuarios(this.usuarios);

  inicializarPosicaoAtual(){
    if(posicao_marker_atual == -1 && markers!.length > 0){
      posicao_marker_atual = 0;
    }
  }

  LatLng obterPosicaoInicial() {
    return posicao_marker_atual == -1
          // Centro de Colatina
        ? LatLng(-19.5167339, -40.722392)
        : markers!.elementAt(0).position;
  }

  void avancarProximoMarker() {
    if(posicao_marker_atual == (markers!.length-1)){
      posicao_marker_atual = 0;
    } else {
      posicao_marker_atual++;
    }
    final LatLng latlng = markers!.elementAt(posicao_marker_atual).position;
    mapController!.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latlng,
          zoom: 17.0,
        ),
      ),
    );
  }

  Future<BitmapDescriptor> obterBitmapDescriptor(String foto) async {
    if (foto == null || foto == "") {
      return await GeradorBitmapDescriptor.gerarBitMapDescriptorFromAsset(
          'assets/icon/imagem_mapa.png', 100);
    } else {
      File file = await GerenciadoraArquivo.obterImagem(foto);
      return await GeradorBitmapDescriptor.gerarBitMapDescriptorFromFile(
          file, 100);
    }
  }

  Future<List<Marker>> obterMarkers(List<Usuario> usuarios) async {
    List<Marker> markers = <Marker>[];
    for (Usuario usuario in usuarios) {
      LatLng? latLng =
      await Localizador.obterLatitudeLongitudePorEndereco(usuario.endereco!);
      if (latLng != null) {
        BitmapDescriptor userIcon =
        await obterBitmapDescriptor(usuario.urlFoto!);
        Marker marker = Marker(
          markerId: MarkerId(usuario.id.toString()),
          position: latLng,
          icon: userIcon,
          infoWindow: InfoWindow(
            title: usuario.nome,
            snippet: usuario.endereco,
          ),
        );
        markers.add(marker);
      }
    }
    return markers;
  }
}
