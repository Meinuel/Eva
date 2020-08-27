import 'package:evita/utils/providers/fechaaviso_provider.dart';
import 'package:evita/utils/providers/fechaavisoterceros_provider.dart';
import 'package:evita/utils/providers/mail_provider.dart';
import 'package:evita/utils/providers/os_provider.dart';
import 'package:evita/utils/providers/tx_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DynamicPage extends StatefulWidget {

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
 
  double opacidad=0.9;
  double i = 5;
  int iSelectedValue=5; 
  final String sFontActivia = 'Gotham';
  
  @override
  Widget build(BuildContext context) {

  final List<String> lstAlarma = ModalRoute.of(context).settings.arguments;
  final String sIdAlarma = lstAlarma[0],sDescripcion = lstAlarma[1],sMiTipo=lstAlarma[3],
   sObraSocial = lstAlarma[4],sMaxTimeOut=lstAlarma[5],sDatosUtiles = lstAlarma[6],instancia = lstAlarma[7],sFechaError=lstAlarma[8],
   sFechaHoraSolucion=lstAlarma[9],sUser=lstAlarma[10],index=lstAlarma[11];
  String sMiEstadoAviso = lstAlarma[2]; 
  

  return Scaffold(

    backgroundColor: Colors.white,
    body:Opacity(
          opacity:opacidad ,
          child: Column(
            children: <Widget>[  
              Spacer(flex: 1),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top:20),
                child: Text('OS : $sObraSocial'.toUpperCase(),style: TextStyle(fontFamily:sFontActivia,fontSize: 25,color: Colors.red[600],fontWeight: FontWeight.bold),),),
              Spacer(flex: 1), 
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:50),
                    child:Text(_handleFecha(sFechaError,'ERROR : ') ,style: TextStyle(fontFamily:sFontActivia,),),),  
                  Container( 
                    margin: EdgeInsets.symmetric(horizontal:50),        
                    child:Text(_lenghtControl(sDescripcion) ,style: TextStyle(fontFamily:sFontActivia,fontSize: 15),),), 
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:50),
                    child:Text(_lenghtControl(sDatosUtiles) ,style: TextStyle(fontFamily:sFontActivia,),),),  
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:50),
                    child:Text('ESTADO : $sMiEstadoAviso' ,style: TextStyle(fontFamily:sFontActivia,),),),           
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:50),
                    child:Text('TIPO : $sMiTipo' ,style: TextStyle(fontFamily:sFontActivia,),),),     
                  Container(    
                    child:Text(_handleFecha(sFechaHoraSolucion, 'SOLUCIÓN : ') ,style: TextStyle(fontFamily:sFontActivia))),  
                ],
              ),
              Spacer(flex: 1),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child:RaisedButton.icon(
                  onPressed: index == '1' ? null : () async {
                  List<String> rsp ;
                    setState(() {
                      opacidad=0.4;
                    });
                  if(sObraSocial=='OSDE'){}else{
                    final String sXmlTxPrueba = await osProvider.cargodatosOS(sObraSocial);
                    rsp = await txProvider.pruebaTransaccion(sMaxTimeOut,sXmlTxPrueba);}
                  showDialog(
                    builder: (context){
                      return Dialog(
                        child:Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 200,
                          child: Text(rsp != null ? rsp[0] : 'Error en tx de prueba',style: TextStyle(fontSize: 15),),),
                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      );},
                      context: context);  
                  setState(() {
                    opacidad= 0.9 ;
                  });
                },
                icon: SvgPicture.asset('assets/IcoBotonEnviarTx.svg',height: 25),
                label: Text('ENVIAR TX DE PRUEBA',style: TextStyle(fontFamily:sFontActivia)),color: Colors.white),
              ), 
              Spacer(flex: 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text('VOLVER A NOTIFICARME EN :',style: TextStyle(fontFamily:sFontActivia),)),
                  Container(
                    child:_crearSlider(),) ,
                  Container(
                    child:Text("$iSelectedValue MINUTOS",
                      style: TextStyle(fontSize: 15,fontFamily:sFontActivia,fontWeight: FontWeight.w600)
                  )),
                ],
              ),
              Spacer(flex: 2),
              Column(
                children: [
                  _createIconButton(sMiEstadoAviso,index,sIdAlarma,sUser),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child:RaisedButton.icon(
                    onPressed: () async {
                      (sMiEstadoAviso == '2') ? sMiEstadoAviso = '1' : sMiEstadoAviso = sMiEstadoAviso; 
                      String sRsp = await mailProvider.envioMail(sIdAlarma, sMiEstadoAviso);
                      if(sRsp==null){
                        setState(() {
                          sRsp = "Error en el envio, verifique su conexión...";
                        });
                      }else{
                        setState(() {
                          sRsp = "Mail enviado con exito!";
                        });
                      }
                      showDialog(
                      builder: (context){
                        return Dialog(
                          child:Container(
                            alignment: Alignment.center,
                            height: 200,
                            width: 300,
                            child: Text(sRsp,style: TextStyle(fontSize: 15),),),
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        );},
                        context: context);
                      }, 
                      icon: SvgPicture.asset('assets/IcoBotonNotifCliente.svg',height: 25),
                      label: Text('NOTIFICAR CLIENTE',style: TextStyle(fontFamily:sFontActivia),),
                      color: Colors.white)
                    )
                ]),
               ],),
    ),
    );
  }

  _crearSlider() {

    return Slider(
      divisions: 8,
      label: "$iSelectedValue'",
      activeColor: Colors.indigo,
      value:i,
      min:5 ,
      max:120 ,
      onChanged: (value){
      setState(() {
        
        i=value;
        iSelectedValue = i.round();
        if(iSelectedValue==19){
          iSelectedValue = 20;
         
        }else if(iSelectedValue==34){
          iSelectedValue = 30;
         
        }else if(iSelectedValue==48){
          iSelectedValue = 45;
          
        }else if(iSelectedValue==63){
          iSelectedValue = 60;
         
        }else if(iSelectedValue==77){
          iSelectedValue = 90;
          
        }else if(iSelectedValue==91){
          iSelectedValue = 120;

        }else if(iSelectedValue==106){
          iSelectedValue = 360;

        }else if(iSelectedValue==120){
          iSelectedValue = 480;
        }
    
      });
    });
    
    }

  String _handleFecha(String fecha,tipo) {
    if(fecha.length != 12){
      final String sDate = tipo + fecha;
      return sDate;
    }else{
      String sYear = fecha.substring(0,4) + '/';
      String sMonth = fecha.substring(4,6) + '/';
      String sDay = fecha.substring(6,8) + ' - ';
      String sHour = fecha.substring(8,10) + ':';
      String sMinutes = fecha.substring(10,12);
      final String sDate = tipo + sYear + sMonth + sDay + sHour + sMinutes ;
      return sDate;
    }
  }

  _createIconButton(sEstado,index,String idAlarma,String sUser) {

    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
      child:RaisedButton.icon(
        onPressed: sEstado == '1' ? () async {
            final String sTimeOut = iSelectedValue.toString();
            final int idAlarmas = int.parse(idAlarma);
            String sRsp ;
            if(index=='0'){
              sRsp = await fechaAvisoProvider.updateAviso(idAlarmas, sTimeOut, sUser, '');
            }else{
              sRsp = await fechaAvisoTercerosProvider.updateAvisoTerceros(idAlarmas, sTimeOut, sUser, '');
            }
            setState(() {
              opacidad = 0.9;
            });
            if(sRsp==null){     
              setState(() {
                sRsp = "Error, verifique su conexión";
              });                         
            }else{     
              setState(() {
                sRsp = "Se te volvera a notificar en " + sTimeOut + " minutos"; 
              });                               
            }
            showDialog(
            builder:(context){
              return Dialog(
                child:Container(
                alignment: Alignment.center,
                height: 200,
                width: 300,
                child: Text(sRsp,style: TextStyle(fontSize: 15),),),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                );},
            context: context);
            Navigator.pushNamed(context, 'Alertas');
        } : null ,
      icon: SvgPicture.asset('assets/IcoBotonEnterado.svg',height: 25),
      label: Text('ENTERADO',style: TextStyle(fontFamily:sFontActivia)),
      color: Colors.white,),
      ) ;
     }

  String _lenghtControl( String sDescripcion ) {
    if ( sDescripcion.length > 40 ){
      return sDescripcion.substring(0,39);
    } else {
      return sDescripcion;
    }
  }
}