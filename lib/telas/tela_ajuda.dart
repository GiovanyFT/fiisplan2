import 'package:flutter/material.dart';
//import 'package:native_video_view/native_video_view.dart';

class TelaAjuda extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.yellow,
  /*      child: NativeVideoView(
          keepAspectRatio: true,
          showMediaController: true,
          onCreated: (controller) {
            if(Platform.isAndroid){
              controller.setVideoSource(
                'assets/video/apresentando_aplicativo_android.mp4',
                sourceType: VideoSourceType.asset,
              );
            } else {
              controller.setVideoSource(
                'assets/video/apresentando_aplicativo_ios.mp4',
                sourceType: VideoSourceType.asset,
              );
            }
          },
          onPrepared: (controller, info) {
            controller.play();
          },
          onError: (controller, what, extra, message) {
            print('Player Error ($what | $extra | $message)');
          },
          onCompletion: (controller) {
            print('Video completed');
          },
        ),
      */
      ),
    );
  }
}
