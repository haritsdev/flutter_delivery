import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/pages/login/login_page.dart';
import 'package:flutter_delivery_udemy/src/pages/register/register_page.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'register' : (BuildContext context) => RegisterPage(),
      },
      theme: ThemeData(
        // fontFamily: 'NimbusSans',
        primaryColor: MyColors.primaryColor
      ),
    );
  }
}
