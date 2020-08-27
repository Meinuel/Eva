import 'package:evita/utils/providers/limpieza_provider.dart';
import 'package:evita/utils/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class AlertPage extends StatefulWidget {

  @override
  
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {

final Widget svg = SvgPicture.asset( 
  'assets/evalogo.svg',
  semanticsLabel: 'Acme Logo',
  height: 100,
);

@override
  Widget build(BuildContext context) {
    
    final String sUser = ModalRoute.of(context).settings.arguments;

    return Scaffold( 
      appBar: _createAppBar(),
      body: _listaAlarmas(sUser),   
    );
  }

//CONSULTO WEB SERVICE ALARMAS
  Widget _listaAlarmas(sUser){
    
    return FutureBuilder(
      future: provider.traerAlarmas(sUser,0),
      initialData:Image(image: AssetImage('assets/evalogo.svg')),
      builder:(BuildContext context, AsyncSnapshot snapshot){   
        if(snapshot.hasData){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting: 
              return Center(           
                child:CircularProgressIndicator());
          default:
             final sData = snapshot.data.toString();
             if(sData != 'Error en DB'){     
                 return _createSwiper(sUser,sData);   
               }else {
                 final String sError = 'No tenés conexión o hubo un error en base de datos' ;
                 return _handleError(sUser, sError);
   }}
      }else{
        final String sError = 'No tenés conexión o hubo un error en web service' ;
        return _handleError(sUser,sError);
     }
      });
  }

//-----------------------------------------------------------------------------------------------------------------------------

   _createSwiper(sUser,sData) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Swiper(
        duration: 1000,
        curve: Curves.elasticInOut,
        itemCount: 2,
        itemBuilder:(context,index){
          return  _createTiles(sData,sUser,index);
      }),
    );
  }

  _createTiles(sData,sUser,int index){

    List<Widget> lstAlarmasOk = [];
    List<Widget> lstAlarmasError = [];

    if( sData == ''){
      return _todoOk(sUser,lstAlarmasOk,index);
    }else{
      final List<String> origen = sData.split('|');
      final List<String> alarmas = origen[index].split('>');
      for (var alarma in alarmas) {
        if( alarma.length == 0){}else{
          final List<String> datos = alarma.split('<');
          datos.add(sUser);
          datos.add(index.toString());
          String descripcion = datos[1];
          String tipo = datos[2];

          if( tipo == '0'){

            final tempWidget = _tile(descripcion, datos, Icons.done_all, Colors.green);
            lstAlarmasOk.add(tempWidget);

          }else if ( tipo == '1'){

            final tempWidget = _tile(descripcion, datos, Icons.error_outline, Colors.red[800]);
            lstAlarmasError.add(tempWidget);

          }else{

            final tempWidget = _tile(descripcion, datos, Icons.watch_later, Colors.yellow[800]);
            lstAlarmasError.add(tempWidget);

          }
        }
      }
    }
        if(lstAlarmasError.length == 0){
          return _todoOk(sUser,lstAlarmasOk,index);
        }else{
          return _todoMal(lstAlarmasError,lstAlarmasOk,index);
        }
  }

_tile(String sDescripcion,List<String> lstDatos, IconData icon, Color color){
  return ListTile(   
    leading: Icon(icon, color: color, size: 35),
    trailing: Icon(Icons.arrow_right,color:color,size: 35),
    title: Text(_descripcion(sDescripcion),style: TextStyle(fontFamily:'Gotham')),
    onTap: (){
      Navigator.pushNamed(context, 'Dynamic',arguments: lstDatos);
    },);
}

_todoOk(String sUser, List<Widget> lstAlarmasOk,index){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: lstAlarmasOk.length == 0 ? 80 : 30),
        child: SvgPicture.asset(
          index == 0 
            ? 'assets/PrimarioEstable.svg'
            : 'assets/TercerosEstable.svg'
            ,
          height: MediaQuery.of(context).size.height / 2.5,
    )),
      SizedBox(height:20),
      Expanded(
        child: Container(
          child: ListView(
            children: lstAlarmasOk,
          )
          ),
      )
    ],
  );
}

_todoMal(List<Widget> lstAlarmasError,List<Widget> lstAlarmasOk, int index){
  
  lstAlarmasError.addAll(lstAlarmasOk);
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical:30),
        child: SvgPicture.asset(
          index == 0 
            ? 'assets/PrimarioInestable.svg'
            : 'assets/TercerosInestable.svg',
          height: MediaQuery.of(context).size.height / 2.5,
    )),
      Expanded(
        child: Container(
          child: ListView(
            children: lstAlarmasError,
          )
          ),
      )
    ],
  );
}
  

 _createAppBar() {
    return AppBar (
      actions: <Widget>[
        GestureDetector(
          onDoubleTap: (){
            setState(() {});
          },
          child: SvgPicture.asset(          
            'assets/miniLogoActivia.svg',
            semanticsLabel: 'MiniLogo Activia',
            height: 40,
            alignment: Alignment.centerRight,
          ),
        )
      ],
      leading:GestureDetector(
        onDoubleTap: () async {
          await limpiezaProvider.limpieza("0","0");
          setState(() {});
        },
          child: SvgPicture.asset(
          'assets/miniLogoEva.svg',
          semanticsLabel: 'MiniLogo Eva',
        ),
      ) ,
      backgroundColor: Colors.grey[800],
      );
  }

  _handleError(String sUser,String sError){
    return Column(      
      children:<Widget>[
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:250),
        child:Text(sError)), 
          Container(
            alignment: Alignment.center,
            child:RaisedButton(
              child:Text('Volver a cargar'),
              onPressed: (){
                setState(() {});
              },)
          )]);
 }

  String _descripcion( String sDescripcion) {
    if ( sDescripcion.length > 40 ){
      return sDescripcion.substring(0,39);
    }else{
      return sDescripcion;
    }
  }
}

