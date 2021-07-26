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
                  height: _authMode == AuthMode.Login
                      ? size.height * 0.1
                      : size.height * 0.2,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
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
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'PASSWORD',
                    ),
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  Container(
                    height: size.height * 0.1,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.purple),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
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
            _authMode == AuthMode.Login
                ? size.height * 0.6
                : size.height * 0.78,
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
                    _authMode == AuthMode.Login ? 'Login' : 'Signup',
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
                    _authMode == AuthMode.Login
                        ? 'Signup Instead'
                        : 'Login Instead',
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
