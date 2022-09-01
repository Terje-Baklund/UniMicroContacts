import 'dart:async';
import 'package:contacts/providers/uni_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  late WebViewController controller;
  var curUrl;

  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  void curtUrl(context, url) {
    curUrl = url;
    if (curUrl!.contains("localhost.:3000/callback")) {
      Navigator.pop(context);
    }
  }

  Future<void> handleResponse(auth, grant, url) async {
    await auth.handleAuthorizationResponse(
        grant, Uri.parse(curUrl).queryParameters);
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<UniAuthenticator>(context, listen: false);
    var grant = auth.createGrant();
    var authroizationUrl = auth.getAuthorizationUrl(grant);
    return WebView(
        initialUrl: authroizationUrl.toString(),
        onPageStarted: (url) {
          curUrl = url.toString();
          if (curUrl.contains("localhost.:3000/callback")) {
            handleResponse(auth, grant, curUrl);
            Navigator.pop(context);
          }
        },
        onWebViewCreated: (controller) {
          curUrl = controller.currentUrl();
          this.controller = controller;
        });
  }
}
