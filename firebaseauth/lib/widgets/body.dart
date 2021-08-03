import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/auth.dart';

import '../screen/login_page.dart';
import '../screen/home_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: authData.isAuth ? HomePage() : LoginPage(),
    );
  }
}
