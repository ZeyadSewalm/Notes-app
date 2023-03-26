import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/shared/componants/companants.dart';
import 'package:untitled3/shared/cubit/cubit.dart';
import 'package:untitled3/shared/cubit/statues.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit ,AppState>(
      listener: (context,builder){},
      builder: (context,builder){
        var tasks=AppCubit.get(context).archivedTasks;
        return TaskBuilder(tasks: tasks);},
    );
  }
}
