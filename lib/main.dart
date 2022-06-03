import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/pages/client/products/client_products_list_page.dart';
import 'package:flutter_delivery_udemy/src/pages/client/update/client_update_profile.dart';
import 'package:flutter_delivery_udemy/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_delivery_udemy/src/pages/login/login_page.dart';
import 'package:flutter_delivery_udemy/src/pages/register/register_page.dart';
import 'package:flutter_delivery_udemy/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:flutter_delivery_udemy/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:flutter_delivery_udemy/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:flutter_delivery_udemy/src/pages/roles/roles_page.dart';
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
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/products/list': (BuildContext context) =>
            ClientProductListPage(),
        'update-profile': (BuildContext context) => ClientUpdatePage(),
        'restaurant/orders/list': (BuildContext context) =>
            RestaurantOrdersListPage(),
        'restaurant/categories/create': (BuildContext context) =>
            RestaurantCategoriesPage(),
        'restaurant/products/create': (BuildContext context) =>
            RestaurantCreateProductsPage(),
        'delivery/orders/list': (BuildContext context) =>
            DeliveryOrdersListPage(),
      },
      theme: ThemeData(
          // fontFamily: 'NimbusSans',
          primaryColor: MyColors.primaryColor,
          appBarTheme: AppBarTheme(elevation: 0)),
    );
  }
}
