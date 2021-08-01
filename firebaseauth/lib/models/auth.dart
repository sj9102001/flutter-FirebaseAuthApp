import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Auth with ChangeNotifier {
  // String _token;
  // DateTime _expiryTime;
  // String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    print(email);
    print(password);
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBCJjHKhPOiKKSBjeuawqyflKv-w5mJXMo');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(response.body);
  }

  void signIn(String email, String password) {
    _authenticate(email, password, 'signUp');
  }
}
