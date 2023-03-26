import 'package:flutter/material.dart';
class BMI_Result extends StatelessWidget {
  bool  isMale;
  int age;
  double result;
  BMI_Result(
      {Key key,
        this.isMale,
        this.age,
        this.result,
      }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('BMI_RESULT'),
      ),
      body:
      Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gender=${isMale ?'male':'fmale'}',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            Text('result=$result',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            Text('age=$age',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
          ],
        ),
      ),
    );
  }
}