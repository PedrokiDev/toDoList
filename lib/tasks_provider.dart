import 'package:flutter/foundation.dart';
import 'database_helper.dart';
import 'task_model.dart';

class TasksProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _dbHelper.getTasks();
    print("TasksProvider: Tarefas carregadas, total: ${_tasks.length}");
    notifyListeners();
  }

  Future<void> addTask(String taskText) async {
    if (taskText.isEmpty) {
      print("TasksProvider: Tentativa de adicionar tarefa com texto vazio");
      return;
    }

    final newTask = Task(text: taskText, isDone: false);
    await _dbHelper.insertTask(newTask);
    print("TasksProvider: Nova tarefa '$taskText' inserida no banco.");
    await loadTasks();
  }

  Future<void> updateTaskStatus(int taskId, bool newIsDoneStatus) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);

    if (taskIndex != -1) {
      Task taskToUpdate = _tasks[taskIndex];
      taskToUpdate.isDone = newIsDoneStatus;

      await _dbHelper.updateTask(taskToUpdate);
      print(
        "TaskProvider: Tarefa com ID $taskId atualizada no banco. Novo isDone: $newIsDoneStatus",
      );
      await loadTasks();
    } else {
      print(
        "TaskProvider: Tarefa com ID $taskId não encontrada para atualizar o status.",
      );
    }
  }

  Future<void> deleteTask(int taskId) async {
    await _dbHelper.deleteTask(taskId);
    print("TaskProvider: Tarefa com ID $taskId deletada do banco.");
    await loadTasks();
  }
}
