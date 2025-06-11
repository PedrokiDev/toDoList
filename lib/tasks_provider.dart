import 'package:flutter/foundation.dart';
import 'database_helper.dart';
import 'task_model.dart';

class TasksProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get pendingTasks {
    final pending = _tasks.where((task) => !task.isDone).toList();
    print("TasksProvider: Getter pendingTasks chamado, ${pending.length} tarefas pendentes");
    return pending;
  }

  List<Task> get recentCompletedTasks {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

    final completedRecently = _tasks.where((task) {
      if (!task.isDone || task.completionDate == null) {
        return false;
      }
      return task.completionDate!.isAfter(thirtyDaysAgo);
    }).toList();

      print("TasksProvider: Getter recentCompletedTasks chamado, ${completedRecently.length} tarefas concluídas recentemente.");
      return completedRecently;
  }

  Future<void> loadTasks() async {
    _tasks = await _dbHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String taskText) async {
    if (taskText.isEmpty) {
      return;
    }

    final newTask = Task(text: taskText, isDone: false);
    await _dbHelper.insertTask(newTask);
    await loadTasks();
  }

  Future<void> updateTaskStatus(int taskId, bool newIsDoneStatus) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);

    if (taskIndex != -1) {
      Task taskToUpdate = _tasks[taskIndex];
      taskToUpdate.isDone = newIsDoneStatus;

      if (newIsDoneStatus == true) {
        taskToUpdate.completionDate = DateTime.now();
        print("TasksProvider: Tarefa ID $taskId marcada como concluída em ${taskToUpdate.completionDate}");
      } else {
        taskToUpdate.completionDate = null;
        print("TasksProvider: Tarefa ID $taskId marcada como não concluída, completionDate zerada.");
      }

      await _dbHelper.updateTask(taskToUpdate);
      await loadTasks();
    } else {
      print("TasksProvider: Tarefa com ID $taskId não encontrada para atualizar o status");
      await loadTasks();
    }
  }

  Future<void> deleteTaskById(int taskId) async {
    await _dbHelper.deleteTask(taskId);
    await loadTasks();
  }
}
