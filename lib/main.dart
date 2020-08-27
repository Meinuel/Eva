import 'package:evita/utils/route_pages.dart';
import 'package:flutter/material.dart';
import 'bloc/provider_inherited.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        color: Colors.green[800],
        title: 'Eva',
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes:getApplicationRoutes() ,
      ),
    );
  }
}
