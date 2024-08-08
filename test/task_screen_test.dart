import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/usecases/get_tasks.dart';
import 'package:todo/presentation/blocs/task_bloc.dart';
import 'package:todo/presentation/blocs/task_event.dart';
import 'package:todo/presentation/blocs/task_state.dart';
import 'package:todo/presentation/screens/task_screen.dart';


class MockTaskBloc extends Bloc<TaskEvent, TaskState> implements TaskBloc {
  MockTaskBloc(super.initialState);

  @override
  // TODO: implement addTask
  AddTask get addTask => throw UnimplementedError();

  @override
  // TODO: implement deleteTask
  DeleteTask get deleteTask => throw UnimplementedError();

  @override
  // TODO: implement getTasks
  GetTasks get getTasks => throw UnimplementedError();

  @override
  // TODO: implement updateTask
  UpdateTask get updateTask => throw UnimplementedError();
}

void main() {
  late MockTaskBloc mockTaskBloc;

  setUp(() {
    mockTaskBloc = MockTaskBloc(const TaskState());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<TaskBloc>(
        create: (_) => mockTaskBloc,
        child: const TaskScreen(),
      ),
    );
  }

  testWidgets('should display a list of tasks when state is TaskLoaded',
          (WidgetTester tester) async {
        final tasks = [
          Task(id: '1', title: 'Task 1'),
          Task(id: '2', title: 'Task 2'),
        ];


        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pump();

        expect(find.byType(ListTile), findsNWidgets(2));
      });

  // Additional widget tests...
}
