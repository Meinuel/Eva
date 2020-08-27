import 'dart:async';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class UserProvider {

 String sRsp;
 //final String _sUrl = 'http://10.0.2.2:3856/Service2.asmx';
 //final String _sUrl = 'http://192.168.0.188:3856/Service2.asmx?';
  final String _sUrl = 'http://eva.activiaweb.com.ar/Service.asmx';

  Future<String> traerValidacion (String sUser,String sPass) async {
    

    final String sRequestBody ='''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <LogueoFlutter xmlns="http://tempuri.org/">
      <pusuario>$sUser</pusuario>
      <pcontraseña>$sPass</pcontraseña>
    </LogueoFlutter>
  </soap:Body>
</soap:Envelope>''';
try {

      http.Response response = await http.post(
        _sUrl,
        headers: {
          'Host'        : 'eva.activiaweb.com.ar',
          'Content-Type': 'text/xml; charset=utf-8',
          'SOAPAction'  : 'http://tempuri.org/LogueoFlutter'
        }, 
        body: utf8.encode(sRequestBody)
      );
 
   
  sRsp =response.body;

  final raw = xml.XmlDocument.parse(sRsp);
  final elements = raw.findAllElements('LogueoFlutterResult');
  var respuesta = elements.single.text;

  return respuesta;
  } catch (e) {
  return null;  
}
  }
}
final userProvider = new UserProvider();