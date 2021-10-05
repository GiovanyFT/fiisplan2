import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TelaWebViewFundos extends StatefulWidget {
  String url;

  TelaWebViewFundos(this.url);

  @override
  _TelaWebViewFundosState createState() => _TelaWebViewFundosState();
}

class _TelaWebViewFundosState extends State<TelaWebViewFundos> {
  var _indice_pilha = 1;
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return IndexedStack(
      index: this._indice_pilha,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl: this.widget.url,
                onWebViewCreated: (controller) {
                  _controller = controller;
                },
                // Habilita o JavaScript
                javascriptMode: JavascriptMode.unrestricted,
                // Permite navegar na página
                navigationDelegate: (request){
                  return NavigationDecision.navigate;
                },
                onPageFinished: (value){
                  setState(() {
                    this._indice_pilha = 0;
                  });
                },
              ),
            ),
          ],
        ),

        Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
