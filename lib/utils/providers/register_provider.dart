import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;


class RegisterProvider{

 String sRsp;
 String _sUrl = 'http://eva.activiaweb.com.ar/Service.asmx';
 //String _sUrl = 'http://10.0.2.2:3856/Service2.asmx';

Future<String> registrarUsuario(sUser,sMail,sPin)async{

  String sRequestBody = 
 '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <RegistroMail xmlns="http://tempuri.org/">
      <pusuario>$sUser</pusuario>
      <pemail>$sMail</pemail>
      <pclave>$sPin</pclave>
    </RegistroMail>
  </soap:Body>
</soap:Envelope>''';

  try {
    
 
  http.Response response = await http.post(
    _sUrl,
    headers: {
        'Host'        : 'eva.activiaweb.com.ar',
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction'  : 'http://tempuri.org/RegistroMail'
      },
      body: utf8.encode(sRequestBody),
  );

  sRsp =response.body;
  
  final raw = xml.XmlDocument.parse(sRsp);
  final elements = raw.findAllElements('RegistroMailResult');
  var respuesta = elements.single.text;
  
  return respuesta;
   } catch (e) {
     return 'Error, chequea tu conexión o los datos ingresados';
  }
}

}
final registerProvider = new RegisterProvider();