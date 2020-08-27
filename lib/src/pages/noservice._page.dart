import 'package:flutter/material.dart';
class NoService extends StatelessWidget {
  const NoService({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sin conexión!'),
            SizedBox(height:20),
            RaisedButton(
              child: Text('Reintentar'),
              onPressed: (){
                Navigator.pushNamed(context, '/');
              })
          ],
        ),
      ),
    );
  }
}