import 'package:evita/bloc/registro_bloc.dart';
import 'package:flutter/material.dart';

class Registrarse extends StatelessWidget {
  
  final RegistrarBloc registrarBloc = RegistrarBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<String>(
                  stream: registrarBloc.nameStream,
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal:40),
                      child: TextField(
                        onChanged: registrarBloc.nameSink,
                        decoration: InputDecoration(
                          hintText: 'Usuario / Nombre')
                      ),
                    );
                  }
                ),
                StreamBuilder<String>(
                  stream: registrarBloc.passStream,
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal:40),
                      child: TextField(
                        obscureText: true,
                        onChanged: registrarBloc.passSink,
                        decoration: InputDecoration(
                          errorText: snapshot.error,
                          hintText: 'Nueva contraseña ')
                      ),
                    );
                  }
                ),
                StreamBuilder<String>(
                  stream: registrarBloc.mailStream,
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal:40),
                      child: TextField(
                        onChanged: registrarBloc.mailSink,
                        decoration: InputDecoration(
                          errorText: snapshot.error,
                          hintText: 'Tu mail dentro de activia'),
                      ),
                    );
                  }
                ),
                StreamBuilder<bool>(
                  stream: registrarBloc.formValidStream,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      color: Colors.green,
                      child: Text('OK!',style: TextStyle(color: Colors.white)),
                      onPressed: snapshot.hasData 
                        ? () async {
                          DateTime dNow = new DateTime.now();
                          int iAhora = dNow.microsecond*7;
                          //final rsp = await registerProvider.registrarUsuario(registrarBloc.nameValue,registrarBloc.mailValue, iAhora);
                          Navigator.pushNamed(context, 'Pin',arguments:[registrarBloc.nameValue,registrarBloc.mailValue, iAhora,registrarBloc.passValue]);
                        }
                        : null
                    );
                  }
                )
              ],
          )));
  }
}