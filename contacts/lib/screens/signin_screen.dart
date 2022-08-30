import 'dart:async';

import 'package:flutter/material.dart';
import '../providers/uni_authenticator.dart';
import 'authorization_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    var auth = UniAuthenticator();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 40),
              child: Image.asset('assets/images/Unimicro.png')),
        ),
        // Text(
        //   "Hello There",
        //   style: Theme.of(context).textTheme.headline3,
        // ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: const Size(140, 60)),
          child: const Text('Sign In', style: TextStyle(fontSize: 25)),
          onPressed: () {
            // var auth = UniAuthenticator();
            // auth.signIn((authorizationUrl) {
            //   final completer = Completer<Uri>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthorizationPage(),
                // authorizationUrl: authorizationUrl,
                // onAuthorizationCodeRedirectAttempt: (redirectUrl) {
                //   completer.complete(redirectUrl);
                // },
                //     ),
              ),
            );
            // print(
            //     "COMPLETE ---------------------------------------------------------------------------------------------");
            // return completer.future;
            // });
          },
        ),
      ]),
    ));
  }
}
