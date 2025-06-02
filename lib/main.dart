import 'package:flutter/material.dart';
import 'package:to_do_list/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> _tasks = [];

  void _refreshTasks() async {
    final dataFromDb = await DatabaseHelper().getTasks();
    setState(() {
      _tasks.clear();

      for (var taskFromDb in dataFromDb) {
        _tasks.add(Map<String, dynamic>.from(taskFromDb));
      }
      print("Refresh: _tasks agora tem ${_tasks.length} itens e são: $_tasks");
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoList',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),

      home: Scaffold(
        appBar: AppBar(
          title: const Text('To do List'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final Map<String, dynamic> currentTask = _tasks[index];

            print(
              "Construindo ListTile para: ${currentTask['text']}, isDone (int) ${currentTask['isDone']}",
            );

            return ListTile(
              leading: Checkbox(
                value: currentTask['isDone'] == 1,
                onChanged: (bool? newValue) async {
                  if (newValue != null) {
                    final int taskId = currentTask['id'];
                    final String taskText = currentTask['text'];
                    int newIsDoneValue = newValue ? 1 : 0;

                    setState(() {
                      final taskInList = _tasks.firstWhere((task) => task['id'] == taskId);
                      taskInList['isDone'] = newIsDoneValue;
                      print(
                        "Dentro do setState (UI): _tasks[$index]['isDone'] agora é: $newIsDoneValue",
                      );
                    });

                    Map<String, dynamic> taskForDbUpdate = {
                      'id': taskId,
                      'text': taskText,
                      'isDone': newIsDoneValue,
                    };

                    await DatabaseHelper().updateTask(taskForDbUpdate);
                    print(
                      "Tarefa '$taskText' (ID: $taskId) ATUALIZADA no banco. Novo isDone: $newIsDoneValue",
                    );
                  }
                },
              ),
              title: Text(currentTask['text']),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: Text('Confirmar exclusão?'),
                        content: Text(
                          "Tem certeza que deseja excluir a tarefa '${currentTask['text']}'?",
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Excluir'),
                            onPressed: () async {
                              final int taskIdToDelete = currentTask['id'];

                              await DatabaseHelper().deleteTask(taskIdToDelete);
                              print("Tarefa com ID $taskIdToDelete DELETADA do banco");

                              if (mounted) Navigator.of(dialogContext).pop();

                              _refreshTasks();
                              print("Lista da UI atualizada após deleção.");
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: Builder(
          builder: (BuildContext newContext) {
            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: newContext,
                  builder: (BuildContext dialogContext) {
                    final TextEditingController taskController =
                        TextEditingController();
                    return AlertDialog(
                      title: Text('Adicionar nova tarefa'),
                      content: TextField(
                        controller: taskController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Digite a nova tarefa',
                        ),
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
                          onPressed: () async {
                            if (taskController.text.isNotEmpty) {
                              final newTaskData = {
                                'text': taskController.text,
                                'isDone': 0,
                              };

                              await DatabaseHelper().insertTask(newTaskData);

                              _refreshTasks();
                            }

                            if (mounted) Navigator.of(dialogContext).pop();
                          },
                        ),
                      ],
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
