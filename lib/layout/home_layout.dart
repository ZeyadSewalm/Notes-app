import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled3/modules/archived_tasks/archived_tasks.dart';
import 'package:untitled3/modules/done_tasks/done_tasks.dart';
import 'package:untitled3/modules/new_tasks/new_tasks.dart';
import 'package:untitled3/shared/componants/companants.dart';
import 'package:untitled3/shared/componants/constants.dart';
import 'package:untitled3/shared/cubit/cubit.dart';
import 'package:untitled3/shared/cubit/statues.dart';

class HomeLayout extends StatelessWidget

 {
    var scaffoldKey=GlobalKey<ScaffoldState>();
    var formKey=GlobalKey<FormState>();

    var titleContraller=TextEditingController();
    var timeContraller=TextEditingController();
  var dateContraller=TextEditingController();
  HomeLayout({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state){
          if(state is AppInsertDataBaseState){Navigator.pop(context);}
        },
        builder:(context,state){
          AppCubit cubit =AppCubit.get(context);
          return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text( cubit.titles[ cubit.currentIndex]),
          ),
          body: ConditionalBuilder(condition:state is! AppGetDataBaseLoadingState,builder:(context)=> cubit.screens[ cubit.currentIndex] ,fallback: (context)=>Center(child: const CircularProgressIndicator()),),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(cubit.isBottomSheetShown){
                if(formKey.currentState.validate()){
                  cubit. insertDatabase(title:titleContraller.text ,date: dateContraller.text,time: timeContraller.text);
                  // insertDatabase(title:titleContraller.text ,date: dateContraller.text,time: timeContraller.text).then((value) {
                  //   getDataFromDatabase(database).then((value) {
                  //     Navigator.pop(context);
                  //     //   setState(() {
                  //     //   isBottomSheetShown=false;
                  //     //   fabIcon=Icons.edit;
                  //     //   tasks=value;
                  //     //   print(tasks);
                  //     // });
                  //   });
                  // });
                }
              }
              else
              {
                scaffoldKey.currentState.showBottomSheet((context) =>
                    Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                                controller: titleContraller,
                                type:TextInputType.text ,
                                validate: (String value ){if(value.isEmpty){return 'value must not be empty';}},
                                label: 'task title',
                                prefix: Icons.title),
                            SizedBox(height: 15,),
                            defaultFormField(
                                controller: timeContraller,
                                type:TextInputType.datetime ,
                                onTap: (){
                                  showTimePicker(context: context,
                                      initialTime:TimeOfDay.now()).then((value) {timeContraller.text=value.format(context).toString();print(value.format(context));});},
                                validate: (String value ){if(value.isEmpty){return 'value must not be empty';}},
                                label: 'task time',
                                prefix: Icons.watch_later_rounded),
                            SizedBox(height: 15,),
                            defaultFormField(
                                controller: dateContraller,
                                type:TextInputType.datetime ,
                                onTap: (){
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate:DateTime.parse('2023-12-12')).then((value) {dateContraller.text=DateFormat.yMMMd().format(value);});
                                },
                                validate: (String value ){if(value.isEmpty){return 'value must not be empty';}},
                                label: 'task date',

                                prefix: Icons.calendar_today)

                          ],
                        ),
                      ),
                    )).closed.then((value)
                {
                  cubit.changeBottomSheetState(isShown: false, icon: Icons.edit);

                });
                cubit.changeBottomSheetState(isShown: true, icon: Icons.add);

              }
            },
            child:  Icon(cubit.fabIcon),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:  cubit.currentIndex,
            onTap: (index) {

                 cubit.changeIndex(index);

            },
            items:  [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_outline_sharp), label: 'done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: 'archived'),
            ],
          ),
        );} ,
      ),
    );
  }




}
