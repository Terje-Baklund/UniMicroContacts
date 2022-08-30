import 'dart:convert';

import 'package:contacts/models/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:oauth2/oauth2.dart';
import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

import 'package:contacts/screens/check_login_screen.dart';

typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUrl);

class UniAuthenticator with ChangeNotifier {
  var accessToken;
  String? _companyKey = null;
  List<Company> allCompanies = [];
  bool _isLoggedIn = false;
  bool _isLoading = false;
  FlutterAppAuth appAuth = FlutterAppAuth();

  var _credentials;

  void setSelectedCompanyKey(key) {
    _companyKey = key;
    print("Notifying listeners");
    notifyListeners();
  }

  get companyKey => _companyKey;
  static const clientId = '41da138d-19a4-4000-8e18-0dadad22b6bf';
  static const scopes = [
    "AppFramework",
    "AppFramework.All",
    "offline_access",
    "profile",
    "openid"
  ];
  static final authorizationEndpoint =
      Uri.parse('https://test-login.softrig.com/connect/authorize');
  static final tokenEndpoint =
      Uri.parse('https://test-login.softrig.com/connect/token');
  static final redirectURL = Uri.parse('http://localhost.:3000/callback');
  static final endpointURL = Uri.parse('http://localhost:8080');

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  Credentials get credentials => _credentials;

  Future<void> getCompanyKeys() async {
    bool same = true;
    Uri url = Uri.parse("https://test-api.softrig.com/api/init/companies");
    try {
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json"
      });
      var body = json.decode(response.body);
      var allCurrentKeys = allCompanies.map((co) => co.key);
      for (var co in body) {
        var newCompany = Company(name: co['Name'], key: co['Key']);
        if (allCurrentKeys.contains(newCompany.key)) {
          break;
        }
        allCompanies.add(newCompany);
        same = false;
      }
      // -------Her er det noe ------
      if (same) return;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  AuthorizationCodeGrant createGrant() {
    return AuthorizationCodeGrant(
      clientId,
      authorizationEndpoint,
      tokenEndpoint,
      secret: "",
    );
  }

  Uri getAuthorizationUrl(AuthorizationCodeGrant grant) {
    return grant.getAuthorizationUrl(redirectURL, scopes: scopes);
  }

  Future<void> handleAuthorizationResponse(
      AuthorizationCodeGrant grant, Map<String, String> queryParams) async {
    _isLoading = true;
    notifyListeners();
    try {
      final httpClient = await grant.handleAuthorizationResponse(queryParams);
      print("$httpClient ------------- http Colient ----------------");
      print(httpClient.toString());
      _credentials = httpClient.credentials;
      accessToken = json.decode(credentials.toJson())['accessToken'];
      print("$_credentials ------------- credentials ----------------");
      var stringCredentials = _credentials.toJson();
      print(stringCredentials);
      print("Above were credentials");
      _isLoggedIn = true;
      print(isLoggedIn);
    } on FormatException {
      print("Format Exception");
    } on AuthorizationException catch (error) {
      print(error);
    } on PlatformException {
      print("Platform Exception");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signIn(AuthUriCallback authorizationCallback) async {
    final grant = createGrant();
    print("Grant created -----------------------------------");
    final redirectUrl = await authorizationCallback(getAuthorizationUrl(grant));
    print("Redirected -----------------------------------");
    await handleAuthorizationResponse(grant, redirectUrl.queryParameters);
    print("Done waiting for handler -----------------------------------");
    grant.close();
  }
}
