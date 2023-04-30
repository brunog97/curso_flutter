import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiresDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final isValid = _expiresDate?.isAfter(DateTime.now()) ?? false;

    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> _authenticate(
      String email, String password, String metodoUrl) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$metodoUrl?key=AIzaSyBv4L5_DtZY6QXt68zIom-tqXy6YvWWtFA';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      // requisição bem sucedida
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];

      _expiresDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            body['expiresIn'],
          ),
        ),
      );

      //Presistindo os dados de login na aplicação
      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'expiresDate': _expiresDate!.toIso8601String(),
      }).then((_) {
        //print('Esta autenticado: $isAuth');
        _autoLogout(); //AutoLogout pra fazer sair da app quando o token vencer
        notifyListeners();
      });
    }

    //print(body);
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async {
    //Esta autenticado?
    if (isAuth) return;

    final userData = await Store.readMap('userData');

    if (userData.isEmpty) return;

    // Token Vencido
    final expiresDate = DateTime.parse(userData['expiresDate']);

    if (expiresDate.isBefore(DateTime.now())) return;

    //Token Restaurado
    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expiresDate = expiresDate;

    _autoLogout();
    notifyListeners();
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _expiresDate = null;
    clearAutoLogoutTimer();
    Store.remove('userData').then((_) => notifyListeners());
  }

  void clearAutoLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    clearAutoLogoutTimer();
    final timeToLogout = _expiresDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }
}
