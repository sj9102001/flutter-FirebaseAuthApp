import 'package:flutter/material.dart';

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

  Map<String, String> _authData = {'email': '', 'password': ''};

  void _authenticate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    print('${_authData['email']}');
    print('${_authData['password']}');
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
                  onPressed: () {},
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
