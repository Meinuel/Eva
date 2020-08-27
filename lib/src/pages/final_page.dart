import 'package:evita/utils/providers/pass_provider.dart';
import 'package:flutter/material.dart';

class Final extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<dynamic> lstArguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: FutureBuilder(
        future: passProvider.registrarPass(lstArguments[0], lstArguments[3], lstArguments[2]),
        builder: (context,snapshot){
          if ( snapshot.connectionState == ConnectionState.waiting ){
            return Center(
              child: CircularProgressIndicator() 
            );
          }else{
            if(snapshot.data == 'OK'){
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Listo!'),
                    SizedBox(height: 20),
                    FlatButton(
                      onPressed: (){
                        Navigator.pushNamed(context, 'Login');
                      }, 
                      child: Text('Iniciar Sesion'))
                  ],
                ),
              );
            }else{
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error!'),
                    SizedBox(height: 20),
                    FlatButton(
                      onPressed: (){
                        Navigator.pushNamed(context, 'Pin',arguments: lstArguments);
                      }, 
                      child: Text('Reingresar Pin'))
                  ],
                ),
              );              
            }
          }
        }),
    );
  }
}