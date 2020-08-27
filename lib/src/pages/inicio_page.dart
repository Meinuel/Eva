import 'package:evita/utils/providers/fcm_provider.dart';
import 'package:evita/utils/providers/user_provider.dart';
import 'package:evita/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
Future user = SharedPrefs().getPref();
  @override
  void initState() {
     super.initState();
      user.then((userCredenciales) {
        if(userCredenciales == null){
          Navigator.pushNamed(context, 'Login');
        }else{
          Future rsp = userProvider.traerValidacion(userCredenciales[0], userCredenciales[1]);
          rsp.then((value) {
            if(value == "0" || value == "1"){
              Navigator.pushNamed(context, 'Login');
            }else if (value == 'False' || value == null){
              Navigator.pushNamed(context, 'NoService');
            }else{
              final fcmProvider = new FcmProvider();
              fcmProvider.initNotification(userCredenciales[0]);
              fcmProvider.mensajes.listen((sData){
                if(sData != "keepalive"){
                  Navigator.pushNamed(context, 'Alertas', arguments: userCredenciales[0]);
                }
             });
             Navigator.pushNamed(context, 'Alertas', arguments: userCredenciales[0]);
            }
          });
        }
      });
   }
   
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child:_createImg()
      ));
  }

_createImg() {
  final Widget svg = SvgPicture.asset( 
    'assets/evalogo.svg',
    height: 100,
  );
  return svg;
} 
}