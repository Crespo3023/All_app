import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Daily Planner')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Eliminar Tarea'),
                        content: Text('¿Está seguro de eliminar esta tarea?'),
                        actions: [
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text('Eliminar'),
                            onPressed: () {
                              setState(() {
                                tasks.removeAt(index);
                              });
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Tarea eliminada')));
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              },
            ),
            onTap: () async {
              // Transición para editar la tarea
              final updatedTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskFormScreen(task: task),
                ),
              );

              if (updatedTask != null) {
                setState(() {
                  tasks[index] = updatedTask; // Actualiza la tarea en la lista
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskFormScreen()),
          ).then((newTask) {
            if (newTask != null) {
              setState(() {
                tasks.add(newTask);
              });
            }
          });
        },
      ),
    );
  }
}
