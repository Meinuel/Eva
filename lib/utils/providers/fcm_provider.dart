import 'dart:async';
import 'dart:io';
import 'package:evita/utils/providers/updatetoken_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmProvider{
 
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {

    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }
  
  initNotification(user){
    
    _firebaseMessaging.requestNotificationPermissions();
      
    _firebaseMessaging.getToken().then((token){

      print(token);    
      updateToken.updateToken(token, user);
      
    });

    _firebaseMessaging.configure(
      
   //cuando esta ejecutada en primer plano
      onMessage: ( info ) {
         String argumento = 'no-data';
        if ( Platform.isAndroid ){
          argumento = info['data']['alarma'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
        return null;
        },
      onLaunch: ( info ) {
         String argumento = 'no-data';
        if ( Platform.isAndroid ){
          argumento = info['data']['alarma'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
        return null;
        },
 //cuando esta ejecutada en segundo plano     
      onResume: ( info ) {
         String argumento = 'no-data';
        if ( Platform.isAndroid ){
          argumento = info['data']['alarma'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
        return null;
        },

      onBackgroundMessage: Platform.isIOS ? null : FcmProvider.onBackgroundMessage,
    );
  }
    dispose(){
      _mensajesStreamController?.close();
    }

  }
