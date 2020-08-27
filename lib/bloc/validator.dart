import 'dart:async';

class Validator{

  final validarPass = StreamTransformer<String, String>.fromHandlers(
    handleData:  ( pass, sink ){
      if ( pass.length < 5 ){
        sink.addError('al menos 6 caracteres, dale...');
      }else{
        sink.add(pass);
      }
    }
  );

  final validarMail = StreamTransformer<String, String>.fromHandlers(
    handleData:  ( mail, sink ){
      if(mail.length > 14 ){
        if ( mail.substring(mail.length - 14, mail.length) != 'activia.com.ar' ){
          sink.addError('el mail no es valido');
        }else{
          sink.add(mail);
        }
      }else{
        sink.addError('el mail no es valido');
      }
      }
  );
}