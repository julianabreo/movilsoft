import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/services/services.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movilsoft'),
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: Container(
        height: 300.0,
        color: Colors.transparent,
        child: new Container(
            decoration: new BoxDecoration(
                color: Colors.green,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )),
            child: new Center(
              child: new Text("Hi modal sheet"),
            )),
      ),
    );
  }
}
