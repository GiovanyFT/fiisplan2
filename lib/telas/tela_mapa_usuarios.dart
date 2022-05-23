import 'dart:async';
import 'package:fiisplan2/dominio/usuario.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'controle_interacao/controle_tela_mapa_usuarios.dart';

class TelaMapaUsuarios extends StatefulWidget {
  List<Usuario> usuarios;

  TelaMapaUsuarios(this.usuarios);

  @override
  _TelaMapaUsuariosState createState() => _TelaMapaUsuariosState();
}

class _TelaMapaUsuariosState extends State<TelaMapaUsuarios> {
  late ControleTelaMapaUsuarios _controle;
  late Future<List<Marker>> future;

  @override
  void initState() {
    super.initState();
    _controle = ControleTelaMapaUsuarios(widget.usuarios);
    future = _controle.obterMarkers(widget.usuarios);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Usuários'),
      ),
      body: _body(),
    );
  }

  _body() {
    return FutureBuilder<List<Marker>>(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _controle.markers = snapshot.data!.toSet();
        _controle.inicializarPosicaoAtual();
        return _conteudo();
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controle.mapController = controller;
  }

  _conteudo() {
    return Stack(
      children: <Widget>[
        Container(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _controle.obterPosicaoInicial(),
              zoom: 17,
            ),
            markers: _controle.markers!,
            onMapCreated: _onMapCreated,
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            child: Icon(Icons.navigate_next),
            onPressed: () {
              _controle.avancarProximoMarker();
            },
          ),
        ),
      ],
    );
  }
}
