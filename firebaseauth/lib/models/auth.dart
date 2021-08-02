import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

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
    try {
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
      final responseBody = json.decode(response.body);
      // print(response.body);
      if (responseBody['error'] != null) {
        print('reaches here');
        throw HttpException(responseBody['error']['message']);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> signUp(String email, String password) {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
