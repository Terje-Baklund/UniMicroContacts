import 'dart:convert';
import 'package:contacts/models/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:oauth2/oauth2.dart';
import 'package:http/http.dart' as http;

class UniAuthenticator with ChangeNotifier {
  var accessToken;
  String? _companyKey;
  List<Company> allCompanies = [];
  bool _isLoggedIn = false;
  bool _isLoading = false;
  FlutterAppAuth appAuth = FlutterAppAuth();
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  Credentials get credentials => _credentials;
  var _credentials;

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

  void setSelectedCompanyKey(key) {
    _companyKey = key;
    notifyListeners();
  }

  Future<List<Company>> getCompanyKeys() async {
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
      return allCompanies;
    } catch (e) {
      print(e);
    }
    return [];
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
      _credentials = httpClient.credentials;
      accessToken = json.decode(credentials.toJson())['accessToken'];
      var stringCredentials = _credentials.toJson();
      _isLoggedIn = true;
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
}
