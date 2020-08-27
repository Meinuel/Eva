import 'package:evita/bloc/registro_bloc.dart';
import 'package:flutter/material.dart';


class Provider extends InheritedWidget{

  final prestacionBloc = RegistrarBloc();

  Provider({Key key , Widget child})
    : super(key:key , child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static RegistrarBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().prestacionBloc;
  }

}