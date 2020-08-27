import 'package:evita/utils/providers/fcm_provider.dart';
import 'package:evita/utils/providers/user_provider.dart';
import 'package:evita/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LogIn extends StatefulWidget {

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  RaisedButton cmdWidget;
  String sUserName;
  String sUserPass;
  double dOpacidad=0.9;
  bool bBolean = false;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _buildPage(),
        );
  }

//------------------------------------------------------------------------------------------------

  _crearInputUser() {
    return Container(
      height: 50,
      child:TextField(
        decoration: InputDecoration(
          labelStyle: TextStyle(fontFamily: 'Gotham'),
          suffixIcon: Icon(Icons.account_circle),
          labelText: 'Usuario',
      ),
       onChanged: (sUserText){
         setState(() {
           sUserName = sUserText;
           bBolean = true;
         });
       },
         ));
   }

//------------------------------------------------------------------------------------------------

  _crearInputPass() {
    return Container(
       height: 50,
       child:TextField(
       obscureText: true,
       decoration: InputDecoration(
         labelStyle: TextStyle(fontFamily: 'Gotham'),
         suffixIcon:Icon(Icons.lock),
         labelText: 'Password',
         ),
       onChanged: (sPassText){
         setState(() {
           sUserPass = sPassText;
         });
       },
         ));
  }

//------------------------------------------------------------------------------------------------

   _createButton() {
      cmdWidget = RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text('Ingresar',
      style: TextStyle(
        color: Colors.white,fontSize: 17,
        fontFamily: 'Gotham'),),
      color: Colors.green[600],
      onPressed:_login
          );

      return cmdWidget;    

  }
 
//------------------------------------------------------------------------------------------------

 _login() async {
   
  SystemChannels.textInput.invokeMethod('TextInput.hide');
     setState(() {
       dOpacidad = 0.4;
     });
   String rsp = await userProvider.traerValidacion(sUserName, sUserPass);
    if(rsp == 'False' || rsp == null){
     _createDialog('SIN CONEXION CON WEB SERVICE');
   }else if(rsp == "0") {
     _createDialog('ERROR EN DB');
   }else if(rsp == '1'){
     _createDialog('USUARIO Y/O CONTRASEÑA INCORRECTA');
   }else{ 
      SharedPrefs().setUser(sUserName,sUserPass);
      final fcmProvider = new FcmProvider();
      fcmProvider.initNotification(sUserName);
      fcmProvider.mensajes.listen((data){
        Future user = SharedPrefs().getPref();
        user.then((value) =>  Navigator.pushNamed(context, 'Alertas', arguments: value[0]));
      });
      Navigator.pushNamed(context, 'Alertas',arguments: sUserName);
   }
     setState(() {
       dOpacidad = 0.9;
     });
   }
  
//------------------------------------------------------------------------------------------------

  _createImg() {
  final Widget svg = SvgPicture.asset( 
  'assets/evalogo.svg',
  semanticsLabel: 'Eva Logo',
  height: 90,
);
return svg;
  }

//------------------------------------------------------------------------------------------------

_createText(){
  return FlatButton(
    onPressed: () => Navigator.pushNamed(context, 'Registracion'),
    child: Text('Generar contraseña'),
  );
}

//------------------------------------------------------------------------------------------------

_buildPage(){
  return Opacity(
    opacity: dOpacidad,
    child:Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child:_createImg()), 
        Container(
          margin: EdgeInsets.symmetric(horizontal:65),
          child: Column(
            children:[
              _crearInputUser(),
              SizedBox(height:20),
              _crearInputPass()
            ])),
        Container(
          child:Column(
            children:[
              _createButton(),
              SizedBox(height:20),
              _createText()
            ])),
        ],));

   }

   _createDialog(sDialogo) {
     return showDialog(
       builder: (context){
         return Dialog(
           shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
           child: Container(alignment: Alignment.center,height: 100,child:Text(sDialogo)));
       },
       context: context);
   }



}