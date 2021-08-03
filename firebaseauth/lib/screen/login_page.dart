import 'package:firebaseauth/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';

import '../constant.dart';
import '../widgets/background_image.dart';

enum AuthMode {
  Login,
  Signup,
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthMode _authMode = AuthMode.Login;
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  Future<void> _showErrorDialog(String message) {
    // print(message);
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

  Map<String, String> _authData = {'email': '', 'password': ''};

  Future<void> _authenticate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      if (_authMode == AuthMode.Login) {
        //login logic
        await Provider.of<Auth>(context, listen: false).signIn(
            _authData['email'].toString(), _authData['password'].toString());
      } else {
        //signup logic
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['email'].toString(), _authData['password'].toString());
      }
    } on HttpException catch (error) {
      var errorMessage = 'Cannot Authenticate';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address already exists';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This email address is not valid';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find user with email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      _showErrorDialog('Cannot Authenticate');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const BackgroundImage(),
        //..............................................................................FORM
        Container(
          margin: EdgeInsets.fromLTRB(
              kDefaultPadding, size.height * 0.351, kDefaultPadding, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: kDefaultPadding),
                  child: TextFormField(
                    onSaved: (value) {
                      _authData['email'] = value.toString();
                    },
                    validator: (value) {
                      if (value.toString() == '') {
                        return 'enter email';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'EMAIL',
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.1,
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: kDefaultPadding),
                  child: TextFormField(
                    obscureText: true,
                    onSaved: (value) {
                      _authData['password'] = value.toString();
                    },
                    validator: (value) {
                      if (value.toString() == '') {
                        return 'enter password';
                      }
                    },
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'PASSWORD',
                    ),
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  Container(
                    height: size.height * 0.1,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        top: 0,
                        bottom: kDefaultPadding),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.purple),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      validator: (value) {
                        if (value.toString() != _passwordController.text) {
                          return 'Password not matching';
                        }
                      },
                      decoration: InputDecoration(hintText: 'CONFIRM PASSWORD'),
                      obscureText: true,
                    ),
                  ),
              ],
            ),
          ),
        ),
        //..............................................................................FORM
        Container(
          // color: Colors.black,
          margin: EdgeInsets.fromLTRB(
            kDefaultPadding,
            _authMode == AuthMode.Login ? size.height * 0.6 : size.height * 0.7,
            kDefaultPadding,
            0,
          ),
          height: size.height * 0.2,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple),
                width: size.width * 0.3,
                child: TextButton(
                  child: Text(
                    _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _authenticate,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple),
                width: size.width * 0.3,
                child: TextButton(
                  child: Text(
                    _authMode == AuthMode.Login ? 'SIGN UP' : 'SIGN IN',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_authMode == AuthMode.Login) {
                        _authMode = AuthMode.Signup;
                      } else {
                        _authMode = AuthMode.Login;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
