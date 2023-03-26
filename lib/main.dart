import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'layout/home_layout.dart';
import 'modules/bmi.dart';
import 'shared/block_opserver.dart';
void main() {
  Bloc.observer = MyBlocObserver();
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}