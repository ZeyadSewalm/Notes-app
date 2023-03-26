import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/shared/componants/companants.dart';
import 'package:untitled3/shared/componants/constants.dart';
import 'package:untitled3/shared/cubit/cubit.dart';
import 'package:untitled3/shared/cubit/statues.dart';

class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

     return BlocConsumer<AppCubit ,AppState>(
       listener: (context,builder){},
       builder: (context,builder){
         var tasks=AppCubit.get(context).newTasks;
         return  TaskBuilder(tasks: tasks) ;},
     );

  }
}
