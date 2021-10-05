import 'package:flutter/material.dart';
import 'package:fiisplan2/util/nav.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class TratadorNotificacao{
  static BuildContext? _context;
  static late FirebaseMessaging _fcm;

  static Future<void> inicializarFCM(BuildContext? context) async {
    _context = context;

    _fcm = FirebaseMessaging.instance;

    _fcm.requestPermission(alert: true, badge: true, sound: true);

    // Quando a aplicação está ativa
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage chamado");
      _showDialog(message.data['mensagem']);
    });

    // Quando a aplicação está voltando ao foco ou está sendo recarregada
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp chamado");
    });
  }

  static void _showDialog(String mensagem) {
    showDialog(
      context: _context!,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: const Text("Notificação"),
          content: Text(mensagem),
          actions: <Widget>[
            // define os botões na base do dialogo
            TextButton(
              child: const Text("Fechar"),
              onPressed: () async {
                pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}



