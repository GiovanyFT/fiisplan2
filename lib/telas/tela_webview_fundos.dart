import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class TelaWebViewFundos extends StatefulWidget {
  @immutable
  final String url;

  TelaWebViewFundos(this.url);

  @override
  _TelaWebViewFundosState createState() => _TelaWebViewFundosState();
}

class _TelaWebViewFundosState extends State<TelaWebViewFundos> {
  var _indice_pilha = 1;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              this._indice_pilha = 0;
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(this.widget.url));
  }

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
              child: WebViewWidget(controller: _controller),
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
