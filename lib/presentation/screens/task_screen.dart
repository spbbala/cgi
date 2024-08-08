import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/blocs/task_bloc.dart';
import 'package:todo/presentation/blocs/task_event.dart';
import 'package:todo/presentation/blocs/task_state.dart';


class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (filter) {
              BlocProvider.of<TaskBloc>(context).add(FilterTasksEvent(filter));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskFilter.all,
                child: Text('All Tasks'),
              ),
              const PopupMenuItem(
                value: TaskFilter.completed,
                child: Text('Completed Tasks'),
              ),
              const PopupMenuItem(
                value: TaskFilter.pending,
                child: Text('Pending Tasks'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('  Note: Long press to delete'),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskLoaded) {
                  return state.filteredTasks.isNotEmpty ? ListView.builder(
                    itemCount: state.filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = state.filteredTasks[index];
                      return ListTile(
                        title: Text(task.title),
                        trailing: Checkbox(
                          value: task.isCompleted,
                          onChanged: (bool? value) {
                            BlocProvider.of<TaskBloc>(context).add(
                              UpdateTaskEvent(task.copyWith(isCompleted: value)),
                            );
                          },
                        ),
                        onLongPress: () {
                          BlocProvider.of<TaskBloc>(context).add(
                            DeleteTaskEvent(task.id),
                          );
                          SnackBar snackdemo = getSnackBar('Data Deleted Successfully!!');
                          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                        },
                      );
                    },
                  ) : Center(child: Text('No Data is Availble'));
                } else {
                  return const Center(child: Text('Error loading tasks'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              onSubmitted: (value) {

                final task = Task(id: DateTime.now().toString(), title: value,isCompleted: false);
                BlocProvider.of<TaskBloc>(context)..add(AddTaskEvent(task))..add(FilterTasksEvent(TaskFilter.all));
                SnackBar snackdemo = getSnackBar('Data Added Successfully');
                ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                textEditingController.clear();
              },
              decoration: const InputDecoration(
                labelText: 'New Task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SnackBar getSnackBar(String data){
    return   SnackBar(
      content: Text(data),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
  }

}
