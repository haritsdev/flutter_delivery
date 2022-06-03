import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery_udemy/src/models/role.dart';
import 'package:flutter_delivery_udemy/src/pages/roles/roles_controller.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _con = new RolesController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   _con.init(context, refresh);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Pilih hak akses anda')),
        body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
          child: ListView(
              children: _con.user != null
                  ? _con.user.roles.map((Role role) {
                      return _cardRole(role);
                    }).toList()
                  : []),
        ));
  }

  Widget _cardRole(Role role) {
    print(role.image);
    setState(() {});
    return GestureDetector(
      onTap: () {
        _con.goToPage(role.route);
      },
      child: Column(
        children: [
          Container(
              height: 100,
              child: FadeInImage(
                  image: role.image != null
                      ? NetworkImage(role.image)
                      : AssetImage('assets/img/no-image.png'),
                  fit: BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'))),
          SizedBox(
            height: 15,
          ),
          Text(role.name != null ? role.name : '',
              style: TextStyle(color: Colors.black, fontSize: 16)),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
