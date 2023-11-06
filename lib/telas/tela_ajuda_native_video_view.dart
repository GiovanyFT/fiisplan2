import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_video_view/native_video_view.dart';

class TelaAjudaNativeVideoView extends StatelessWidget {
  const TelaAjudaNativeVideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajuda"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: NativeVideoView(
          keepAspectRatio: true,
          showMediaController: true,
          onCreated: (controller){
            if(Platform.isAndroid){
              controller.setVideoSource('assets/video/apresentando_aplicativo_android.mp4',
              sourceType: VideoSourceType.asset);
            } else {
              controller.setVideoSource('assets/video/apresentando_aplicativo_ios.mp4',
                  sourceType: VideoSourceType.asset);
            }
          },
          onPrepared: (controller, info){
            controller.play();
          },
          onError: (controller, what, extra, message){
            print("Erro no player: ($what | $extra | $message)");
          },
          onCompletion: (controller){
            print("Video completo");
          },
        ),
      ),
    );
  }
}


