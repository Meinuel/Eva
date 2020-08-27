import 'package:evita/src/pages/alert_page.dart';
import 'package:evita/src/pages/dynamic_page.dart';
import 'package:evita/src/pages/final_page.dart';
import 'package:evita/src/pages/inicio_page.dart';
import 'package:evita/src/pages/log_in.dart';
import 'package:evita/src/pages/noservice._page.dart';
import 'package:evita/src/pages/pin_page.dart';
import 'package:evita/src/pages/registrarse_page.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String,WidgetBuilder>{
    "NoService"    : (BuildContext context) => NoService(),
    "Login"        : (BuildContext context) => LogIn(),
    "Alertas"      : (BuildContext context) => AlertPage(),
    "Dynamic"      : (BuildContext context) => DynamicPage(),
    "Registracion" : (BuildContext context) => Registrarse(),
    "Pin"          : (BuildContext context) => Pin(),
    "Final"        : (BuildContext context) => Final(),
    "/"            : (BuildContext context) => Inicio()
  };
}