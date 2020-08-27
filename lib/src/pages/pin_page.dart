import 'package:evita/utils/providers/register_provider.dart';
import 'package:flutter/material.dart';

class Pin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final List<dynamic> lstArguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: FutureBuilder(
        future: registerProvider.registrarUsuario(lstArguments[0],lstArguments[1],lstArguments[2]),
        builder: (context,snapshot){
          if ( snapshot.connectionState == ConnectionState.waiting ){
            return Center(
              child: CircularProgressIndicator()
              );
          }else{
            if( snapshot.data == "OK" ){
              return _pin(context,lstArguments);
            }else{
              return _error(context);
            }
          }
        },
        ),
    );
  }

  Widget _pin(BuildContext context,lstArguments) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:50),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration:InputDecoration(
                hintText: 'Ingrese pin'
              )
            ),
            SizedBox(height:20),
            RaisedButton(
              child: Text('OK!',style: TextStyle(color:Colors.white)),
              color: Colors.green,
              onPressed: (){
                Navigator.pushNamed(context, 'Final',arguments: lstArguments);
              })
          ],
        )
      ),
    );
  }

  Widget _error(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error al generar contraseña'),
          SizedBox(height:20),
          FlatButton(
            color: Colors.red,
            onPressed: (){
              Navigator.pushNamed(context, 'Registracion');
            }, 
            child: Text('Reintentar',style: TextStyle(color: Colors.white))
          )
        ],
      ),
    );
  }
}