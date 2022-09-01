import 'dart:async';
import 'package:contacts/providers/uni_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
  var auth;
  var grant;
  var authroizationUrl;
  bool notLocked = true;


  void initState() {
    super.initState();
    auth = Provider.of<UniAuthenticator>(context, listen: false);
    grant = auth.createGrant();
    authroizationUrl = auth.getAuthorizationUrl(grant);
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  void curtUrl(url) async {
    curUrl = await url;
    if (curUrl.toString().contains("localhost.:3000/callback")) {
      if (notLocked) {
        handleResponse(auth, grant, url);
      }
      notLocked = false;
    }
  }

  void getDatUrl(Future<dynamic> futureUrl) async {
    var url = await futureUrl;
    print(url);
  }

  Future<void> handleResponse(auth, grant, url) async {
    await auth.handleAuthorizationResponse(
        grant, curUrl.queryParameters);
        Navigator.pop(context);
  }

    
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onWebViewCreated: (controller) => controller = controller,
        initialUrlRequest: URLRequest(url: authroizationUrl),
        onProgressChanged: (controller, progress) {
          curtUrl(controller.getUrl());
        },
        );
  }
}
