import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/task_model.dart';
import 'package:to_do_list/tasks_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        final provider = TasksProvider();
        provider.loadTasks();
        return provider;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoList',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const TasksScreen(),
    );
  }
}

enum TaskListType { pending, completed }

class TasksListView extends StatelessWidget {
  final TaskListType listType;

  const TasksListView({required this.listType, super.key});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = context.watch<TasksProvider>();

    final List<Task> tasks =
        listType == TaskListType.pending
            ? tasksProvider.pendingTasks
            : tasksProvider.recentCompletedTasks;

    if (tasks.isEmpty) {
      return Center(
        child: Text(
          listType == TaskListType.pending
              ? 'Nenhuma tarefa pendente. \nAdicione uma no botão +'
              : 'Nenhuma tarefa concluída recentemente.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final Task currentTask = tasks[index];

        return ListTile(
          leading: Checkbox(
            value: currentTask.isDone,
            onChanged: (bool? newValue) {
              if (newValue != null && currentTask.id != null) {
                context.read<TasksProvider>().updateTaskStatus(
                  currentTask.id!,
                  newValue,
                );
              }
            },
          ),
          title: Text(currentTask.text),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              if (currentTask.id != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Confirmar exclusão?'),
                      content: Text(
                        "Tem certeza que deseja excluir a tarefa '${currentTask.text}'?",
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                        ),
                        TextButton(
                          child: Text('Excluir'),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            context.read<TasksProvider>().deleteTaskById(
                              currentTask.id!,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list_alt_rounded), text: 'Pendentes'),
              Tab(
                icon: Icon(Icons.check_circle_outline_rounded),
                text: 'Concluídas',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TasksListView(listType: TaskListType.pending),
            TasksListView(listType: TaskListType.completed),
          ],
        ),
        floatingActionButton: Builder(
          builder: (BuildContext fabContext) {
            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: fabContext,
                  builder: (BuildContext dialogContext) {
                    final TextEditingController textController =
                        TextEditingController();
                    String? currentErrorText;

                    return StatefulBuilder(
                      builder: (
                        BuildContext sbfContext,
                        StateSetter setStateDialog,
                      ) {
                        return AlertDialog(
                          title: Text('Adicionar Tarefa'),
                          content: TextField(
                            controller: textController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Digite uma tarefa',
                              errorText: currentErrorText,
                            ),
                            onChanged: (text) {
                              if (currentErrorText != null && text.isNotEmpty) {
                                setStateDialog(() {
                                  currentErrorText = null;
                                });
                              }
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Adicionar'),
                              onPressed: () {
                                if (textController.text.isNotEmpty) {
                                  setStateDialog(() {
                                    currentErrorText = null;
                                  });
                                  sbfContext.read<TasksProvider>().addTask(
                                    textController.text,
                                  );
                                  Navigator.of(dialogContext).pop();
                                } else {
                                  setStateDialog(() {
                                    currentErrorText =
                                        'A tarefa não pode estar vazia.';
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              tooltip: 'Adicionar tarefa',
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
