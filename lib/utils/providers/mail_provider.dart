import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class MailProvider {

 String sRsp;
 final String _sUrl = 'http://eva.activiaweb.com.ar/Service.asmx';
 //final String _sUrl = 'http://10.0.2.2:3856/Service2.asmx';

  Future<String> envioMail (String sIdAlarma,String sTipoAvisoMail) async {

    final String sRequestBody ='''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <UpdateEnvioMail xmlns="http://tempuri.org/">
      <idalarma>$sIdAlarma</idalarma>
      <tipoavisomail>$sTipoAvisoMail</tipoavisomail>
    </UpdateEnvioMail>
  </soap:Body>
</soap:Envelope>''';

      http.Response response = await http.post(
        _sUrl,
        headers: {
        'Host'        : 'eva.activiaweb.com.ar',
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction'  : 'http://tempuri.org/UpdateEnvioMail'
        }, 
        body: utf8.encode(sRequestBody)
      );
  sRsp =response.body;
  try {

    final raw = xml.XmlDocument.parse(sRsp);
    final elements = raw.findAllElements('UpdateEnvioMailResult');
    var respuesta = elements.single.text;

  return respuesta;
  } catch (e) {
  return null;
  }
  
  }
}
final mailProvider = new MailProvider();