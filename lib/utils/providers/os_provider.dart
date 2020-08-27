
class OSProvider{
String txCuit;
String txAsociado;
String txPos;
List<String> datosOs;
 cargodatosOS(obraSocial){
if(obraSocial=="OSMELZ"){
txCuit='20044123119';
txAsociado='900099999100';
txPos = '0883';
}else if(obraSocial=='OSMESI'){
txCuit='20043048776';
txAsociado='00000900';
txPos='0199';
}else if(obraSocial=='ACASAL'){
txCuit='33645807869';
txAsociado='18925319';
txPos='1091';
}else if(obraSocial=='OSAPM'){
txCuit='20043663543';
txAsociado='09999999900';
txPos='0674';
}else if(obraSocial=='CESCBA'){
txCuit='30500974016';
txAsociado='148910003';
txPos='0068';
}else if(obraSocial=='CASABA'){
txCuit='30545867679';
txAsociado='9999999900';
txPos='0051';
}else if(obraSocial=='HOPE'){
txCuit='20042641120';
txAsociado='129503899';
txPos='4050';
}else if(obraSocial=='OSADEF'){
txCuit='30519006630';
txAsociado='20211152908';
txPos='0359';
}else if(obraSocial=='OSDIPP'){
txCuit='20040412558';
txAsociado='99999800405';
txPos='0548';
}else if(obraSocial=='SCIS'){
txCuit='20079738442';
txAsociado='14882900';
txPos= '0044';
}else if(obraSocial=='SERVES'){
txCuit='20107220683';
txAsociado='400';
txPos='0868';
}else if(obraSocial=='SIMECO'){
txCuit='20044934435';
txAsociado='199900';
txPos='0662';
}else if(obraSocial=='AMFFA'){
txCuit='20127925314';
txAsociado='1741500';
txPos='0854';
}else if(obraSocial=='PREMED'){
txCuit='20107473905';
txAsociado='0011726582011';
txPos='2206';
}else if(obraSocial=='SWISS'){
txCuit='20220533957';
txAsociado='8000067180171001110';
txPos='0229';
}else if(obraSocial=='TVSALUD'){
txCuit='20185416004';
txAsociado='6106441000905150';
txPos='0840';
}
final String xmlTxPrueba = '''<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?><Mensaje><EncabezadoMensaje><VersionMsj>1.0</VersionMsj>
<TipoMsj>OL</TipoMsj><TipoTransaccion>01A</TipoTransaccion><IdMsj>706171</IdMsj><InicioTrx><FechaTrx>20141022</FechaTrx><HoraTrx>000615</HoraTrx>
</InicioTrx><Terminal><TipoTerminal>PC</TipoTerminal><NumeroTerminal>60000070</NumeroTerminal></Terminal><SetCaracteres>ISO-8859-1</SetCaracteres>
<Financiador><CodigoFinanciador>$obraSocial</CodigoFinanciador><CuitFinanciador></CuitFinanciador><SucursalFinanciador></SucursalFinanciador><SystemTrace></SystemTrace>
</Financiador><Prestador><CuitPrestador>$txCuit</CuitPrestador><SucursalPrestador></SucursalPrestador><RazonSocial></RazonSocial><CodigoPrestador></CodigoPrestador>
<Direccion></Direccion><CodigoParaFinanciador></CodigoParaFinanciador><NroTransaccionInterno></NroTransaccionInterno></Prestador></EncabezadoMensaje>
<EncabezadoAtencion><Credencial><NumeroCredencial>$txAsociado</NumeroCredencial><Track></Track><VersionCredencial>00</VersionCredencial><Vencimiento></Vencimiento>
<ModoIngreso>M</ModoIngreso><EsProvisorio></EsProvisorio><PlanCredencial></PlanCredencial><CondicionIVA></CondicionIVA><NroInternoPaciente></NroInternoPaciente></Credencial>
</EncabezadoAtencion></Mensaje>''';
return xmlTxPrueba;
}
}
final osProvider = new OSProvider();