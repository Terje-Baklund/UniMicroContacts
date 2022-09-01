import 'package:contacts/providers/contacts_provider.dart';
import 'package:contacts/providers/uni_authenticator.dart';
import 'package:contacts/screens/check_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UniAuthenticator>(
            create: (_) => UniAuthenticator()),
        ChangeNotifierProxyProvider<UniAuthenticator, ContactsProvider>(
            create: (_) =>
                ContactsProvider(accessToken: null, companyKey: null),
            update: (_, auth, prevSLP) => ContactsProvider(
                accessToken: auth.accessToken, companyKey: auth.companyKey)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CheckLogin(),
      ),
    );
  }
}
