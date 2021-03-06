import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({Key key}) : super(key: key);

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {
  DeliveryOrdersListController _con = new DeliveryOrdersListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.key,
        appBar: AppBar(leading: _menuDrawer()),
        drawer: _drawer(),
        body: Center(
          child: Text('Delivery orders list'),
        ));
  }

  Widget _menuDrawer() {
    return GestureDetector(
        onTap: _con.openDrawer,
        child: Container(
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/img/menu.png', width: 20, height: 20)));
  }

  Widget _drawer() {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: MyColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_con.user?.name ?? ''}${_con.user?.lastname ?? ''}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                Text(
                  _con.user?.email ?? '',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  maxLines: 1,
                ),
                Text(
                  _con.user?.phone ?? '',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  maxLines: 1,
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 10),
                  child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          : AssetImage(
                              'assets/img/no-image.png',
                            ),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png')),
                )
              ],
            )),
        ListTile(
            onTap: _con.goToRoles,
            title: Text('Keranjang Belanja'),
            trailing: Icon(Icons.shopping_cart_outlined)),
        _con.user != null
            ? _con.user.roles.length > 1
                ? ListTile(
                    title: Text('Pilih Role Sayaj'),
                    trailing: Icon(Icons.person_outline))
                : Container()
            : Container(),
        ListTile(
            onTap: _con.logout,
            title: Text('Logout'),
            trailing: Icon(Icons.power_settings_new))
      ],
    ));
  }

  void refresh() {
    setState(() {});
  }
}
