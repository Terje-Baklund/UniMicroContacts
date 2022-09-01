import 'package:contacts/providers/uni_authenticator.dart';
import 'package:contacts/screens/choose_company_screen.dart';
import 'package:contacts/screens/loading_screen.dart';
import 'package:contacts/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<UniAuthenticator>(context);
    if (authData.isLoading) {
      return const LoadingScreen();
    }
    return (authData.isLoggedIn ? const ChooseCompany() : const SignInPage());
  }
}
