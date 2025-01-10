import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String urll;  // Define as final if it's not supposed to change after instantiation.

  WebViewScreen(this.urll);

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // Use 'urll' inside the build method, where it is available
            if (request.url.startsWith(urll)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(urll));  // Now you can use 'urll' here safely.

    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Screen'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
