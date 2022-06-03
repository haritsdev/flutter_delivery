import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery_udemy/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';

class RestaurantOrdersListPage extends StatefulWidget {
  const RestaurantOrdersListPage({Key key}) : super(key: key);

  @override
  State<RestaurantOrdersListPage> createState() =>
      _RestaurantOrdersListPageState();
}

class _RestaurantOrdersListPageState extends State<RestaurantOrdersListPage> {
  RestauratnOrdersListController _con = new RestauratnOrdersListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.key,
        appBar: AppBar(leading: _menuDrawer()),
        drawer: _drawer(),
        body: Center(
          child: Text('Restorant list order'),
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
            onTap: _con.goToCategoryCreate,
            title: Text('Tambah Kategori'),
            trailing: Icon(Icons.list_alt)),
        ListTile(
            onTap: _con.goToProductCreate,
            title: Text('Tambah Produk'),
            trailing: Icon(Icons.local_pizza)),
        ListTile(
            onTap: _con.goToRoles,
            title: Text('Keranjang Belanja'),
            trailing: Icon(Icons.shopping_cart_outlined)),
        _con.user != null
            ? _con.user.roles.length > 1
                ? ListTile(
                    title: Text('Pilih Role Saya'),
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
