
// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled3/modules/result.dart';
// bool isMale = true;
// double height = 120;
// int age = 20;
// int weight = 50;
// @override
//
// Widget button({
//   Color color= Colors.blue,
//   double width=double.infinity,
//   required  function,
//   required String text,
// }) => Container(
// color:color,
// width: width,
// child: MaterialButton(
// onPressed:
//   function,
// // double result = weight / pow(height / 100, 2);
// // Navigator.push(context, MaterialPageRoute(builder: (context) => BMI_Result(result: result, age: age, isMale: isMale,),),);
// child:  Text(
//   text ,
// style: const TextStyle(color: Colors.white, fontSize: 25),
// ),
// height: 65,
//
// ));

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/shared/cubit/cubit.dart';

Widget defaultFormField({
  @required controller,
  @required type,
  onSubmitt,
  onChange,
  Function onTap,
  bool isclickable = true,
  bool isPassword = false,
  @required validate,
  @required label,
  @required prefix,
  suffix,
  suffixpressed,
}) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      onFieldSubmitted: onSubmitt,
      obscureText: isPassword,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      enabled: isclickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );
Widget buildTaskItem( Map modle,context)=>
    Dismissible(
      key: Key(modle['id'].toString()),
      child: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
      children:  [
        CircleAvatar(radius: 40,child: Text('${modle['time']}'),),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${modle['title']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Text('2 april 2021',style: TextStyle(color: Colors.grey),),

            ],
          ),
        ),
        SizedBox(width: 15,),
        IconButton(onPressed: (){AppCubit.get(context).updateData(status: 'done', id: modle['id']); },icon: Icon(Icons.check_box,color: Colors.lightGreenAccent,),),
        IconButton(onPressed: (){AppCubit.get(context).updateData(status: 'archived', id: modle['id']);},icon: Icon(Icons.archive,color: Colors.black45,),),
      ],
  ),
),
      onDismissed: (direction){ AppCubit.get(context).deleteData(id:modle['id'] );},
    );


Widget TaskBuilder ({@required List<Map> tasks})=>
    ConditionalBuilder(
condition: tasks.length>0,
builder: (context)=>ListView.separated(itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
separatorBuilder:(context,index)=>Container(width:double.infinity,height: 1.0,color: Colors.grey[300],) , itemCount: tasks.length),
fallback: (context)=>Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.menu,color: Colors.grey,size: 100,),
Text('No Tasks Yet,Please Add Some Tasks',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
],),
) );