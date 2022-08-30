import 'dart:async';
import 'dart:io';

import 'package:contacts/providers/uni_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);
  // required this.authorizationUrl,
  // required this.onAuthorizationCodeRedirectAttempt})

  // final Uri authorizationUrl;
  // final void Function(Uri redirectUrl) onAuthorizationCodeRedirectAttempt;

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  // Future<String> authenticate() async {
  //   final result = await FlutterWebAuth2.authenticate(
  //     // url: widget.authorizationUrl.toString(),
  //     callbackUrlScheme: "localhost:3000",
  //   );
  //   print("$result -----------------");
  //   return result;
  // }

  void curtUrl(context, url) {
    // var curUrl = await controller.currentUrl();
    curUrl = url;
    if (curUrl!.contains("localhost.:3000/callback")) {
      Navigator.pop(context);
    }
    print("$url -----------------");
  }

  Future<void> handleResponse(auth, grant, url) async {
    await auth.handleAuthorizationResponse(
        grant, Uri.parse(curUrl).queryParameters);
  }

  late WebViewController controller;
  var curUrl;

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<UniAuthenticator>(context, listen: false);
    var grant = auth.createGrant();
    var authroizationUrl = auth.getAuthorizationUrl(grant);
    return WebView(
        initialUrl: authroizationUrl.toString(),
        onPageStarted: (url) {
          curUrl = url.toString();
          print("$curUrl -----------------");
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
