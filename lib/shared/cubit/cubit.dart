import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled3/modules/archived_tasks/archived_tasks.dart';
import 'package:untitled3/modules/done_tasks/done_tasks.dart';
import 'package:untitled3/modules/new_tasks/new_tasks.dart';
import 'package:untitled3/shared/componants/constants.dart';
import 'package:untitled3/shared/cubit/statues.dart';

class   AppCubit extends Cubit<AppState>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'new tasks',
    'done tasks',
    'archived tasks',
  ];
  void changeIndex( int index){currentIndex=index; emit(AppChangeBottomNavBarState()); }
  void createDatabase()  {
     openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          print('database opened');
          database
              .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT, date TEXT,time TEXT,status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('eror when created table ${error.toString()}');
          });
        }, onOpen: (database) {
           getDataFromDatabase(database);
          print('database created');

        }).then((value) {database=value; emit(AppCreateDataBaseState()); });
  }
   insertDatabase({@required String title,
    @required String date,
    @required String time,}) async{
     await  database.transaction((txn)async
    {
      txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new")').
      then((value) {
        print('$value inserted successfully');
      emit(AppInsertDataBaseState());
      getDataFromDatabase(database);
      }).catchError((error){ print('erorr when inserting new record  ${error.toString()}');});
    }

    );}
  void getDataFromDatabase(database) {
    newTasks=[];
     doneTasks=[];
     archivedTasks=[];
    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element) {
        if(element['status']=='new') {
          newTasks.add(element);
        } else if(element['status']=='done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }


      });
      emit(AppGetDataBaseState());
    });
  }


  void  updateData ({ @required String status,@required int id})async
  {  database.rawUpdate('UPDATE tasks SET status= ? WHERE id= ?',['$status',id],).then((value) {getDataFromDatabase(database); emit(AppUpdateDataBaseState());});
  }
  void  deleteData ({ @required int id})async
  {  database.rawUpdate('DELETE FROM tasks  WHERE id= ?',[id],).then((value) {getDataFromDatabase(database); emit(AppDeleteDataBaseState());});

  }
  bool isBottomSheetShown=false;
  IconData fabIcon=Icons.edit;
  void changeBottomSheetState({@required bool isShown,@required IconData icon }){
    isBottomSheetShown=isShown;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
  }

}