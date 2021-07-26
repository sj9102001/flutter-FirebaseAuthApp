import 'package:flutter/material.dart';

import '../screen/login_page.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginPage(),
    );
  }
}
