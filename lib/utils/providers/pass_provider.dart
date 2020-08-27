import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;


class PassProvider{

 String sRsp;
 String _sUrl = 'http://eva.activiaweb.com.ar/Service.asmx';
 //String _sUrl = 'http://10.0.2.2:3856/Service2.asmx';

Future<String> registrarPass(sUser,sPass,sPin)async{

  String sRequestBody = 
 '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <EstablecerPassword xmlns="http://tempuri.org/">
      <pusuario>$sUser</pusuario>
      <pcontraseña>$sPass</pcontraseña>
      <pclave>$sPin</pclave>
    </EstablecerPassword>
  </soap:Body>
</soap:Envelope>''';

  try {
    
 
  http.Response response = await http.post(
    _sUrl,
    headers: {
        'Host'        : 'eva.activiaweb.com.ar',
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction'  : 'http://tempuri.org/EstablecerPassword'
      },
      body: utf8.encode(sRequestBody),
  );

  sRsp =response.body;
  
  final raw = xml.XmlDocument.parse(sRsp);
  final elements = raw.findAllElements('EstablecerPasswordResult');
  var respuesta = elements.single.text;
  
  return respuesta;
   } catch (e) {
     return 'Error, chequea tu conexión';
  }
}

}
final passProvider = new PassProvider();