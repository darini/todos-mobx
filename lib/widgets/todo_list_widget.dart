import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todos_mobx/controllers/todo_controller.dart';
import 'package:todos_mobx/stores/app_store.dart';
import 'package:todos_mobx/widgets/busy_widget.dart';

class TodoList extends StatelessWidget {
  final _dateFormat = DateFormat('dd/MM/yyyy');

  TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);
    final controller = TodoController(store);

    return Observer(
      builder: (_) => CustomBusy(
        busy: store.busy,
        child: store.todos.isEmpty
            ? const Center(
                child: Text('Nenhuma tarefa encontrada!'),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(left: 40),
                itemCount: store.todos.length,
                itemBuilder: (context, index) {
                  var todo = store.todos[index];

                  return ListTile(
                    title: Text(
                      todo.title!,
                      style: TextStyle(
                          color: todo.done!
                              ? Colors.black.withOpacity(0.2)
                              : Colors.black),
                    ),
                    subtitle: Text(
                      _dateFormat.format(todo.date!),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
