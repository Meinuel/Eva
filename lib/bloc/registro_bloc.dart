import 'package:evita/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class RegistrarBloc with Validator
{
  final _nameController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();
  final _mailController = BehaviorSubject<String>();

  Function(String) get nameSink => _nameController.sink.add;
  Function(String) get passSink => _passController.sink.add;
  Function(String) get mailSink => _mailController.sink.add;

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get passStream => _passController.stream.transform( validarPass );
  Stream<String> get mailStream => _mailController.stream.transform( validarMail );

  Stream<bool> get formValidStream =>
      Observable.combineLatest3(nameStream,passStream,mailStream, (n,p,m) => true);

  String get nameValue => _nameController.value;
  String get passValue => _passController.value;
  String get mailValue => _mailController.value;


  dispose(){
    _nameController?.close();
    _passController?.close();
    _mailController?.close();
  }
}