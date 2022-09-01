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
    return Scaffold(
        body: SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 40),
              child: Image.asset('assets/images/Unimicro.png')),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: const Size(140, 60)),
          child: const Text('Sign In', style: TextStyle(fontSize: 25)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthorizationPage(),
              ),
            );
          },
        ),
      ]),
    ));
  }
}
