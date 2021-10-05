import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class GeradorBitmapDescriptor{

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static Future<BitmapDescriptor> gerarBitMapDescriptorFromAsset(String path, int width) async{
    final Uint8List markerImageBytes = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(markerImageBytes);
  }

  static Future<BitmapDescriptor> gerarBitMapDescriptorFromFile(File file, int width) async{
    final Uint8List markerImageBytes = await file.readAsBytes();
    final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
      markerImageBytes,
      targetWidth: width,
    );

    final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();

    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedMarkerImageBytes);
  }
}
