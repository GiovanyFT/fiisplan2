import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TelaAjuda extends StatefulWidget {
  @override
  _TelaAjudaState createState() => _TelaAjudaState();
}

class _TelaAjudaState extends State<TelaAjuda> {
  late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();
    String string_video;

    if(Platform.isAndroid){
      string_video = 'assets/video/apresentando_aplicativo_android.mp4';
    } else {
      string_video = 'assets/video/apresentando_aplicativo_ios.mp4';
    }

    _videoPlayerController =
        VideoPlayerController.asset(string_video);
    _videoPlayerController.addListener(() {
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              );
            } else {
              return const Text('Aguarde o vídeo carregar');
            }
          },
        ),
      ),
    );
  }
}
