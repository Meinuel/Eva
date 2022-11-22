import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class TxProvider {

  String sRsp;
  final url = Uri.parse('http://activiac.homeip.net/');
  
  Future<List<String>> pruebaTransaccion(maxTimeOut,xmlTxPrueba)async{
    final String sRequestBody = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ExecuteFileTransactionSL xmlns="http://tempuri.org/">
      <pos>0000</pos>
      <fileContent>$xmlTxPrueba</fileContent>
    </ExecuteFileTransactionSL>
  </soap:Body>
</soap:Envelope>
    '''; 
    try {
      List<String> respuestas;
      for (var i = 0; i <= maxTimeOut; i++) {
        
      
      http.Response response = await http.post(
        url,
        headers: {
        'Host'        : 'activiac.homeip.net',
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction'  : 'http://tempuri.org/ExecuteFileTransactionSL'
        },
        body: utf8.encode(sRequestBody));
      sRsp = response.body;

      final raw = xml.XmlDocument.parse(sRsp);
      final elements = raw.findAllElements('ExecuteFileTransactionSLResult');
      var respuesta = elements.single.text; 
      respuestas.add(respuesta);
      
      }
      return respuestas;
    } catch (e) {
      return null;
    }
  }
}
final txProvider = new TxProvider();