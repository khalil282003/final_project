import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/todo_model.dart';
class TaskNotifier extends StateNotifier<List<Todo>> {
  final ApiService apiService;

  TaskNotifier(this.apiService) : super([]) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      state = await apiService.getMyTodos();
    } catch (e) {
      //print('Failed to fetch tasks: $e');
    }
  }

  void clearTasks() {
    state = [];
  }

  Future<void> addTask(String title) async {
    await apiService.addTodo(title);
    fetchTasks();
  }

  Future<void> removeTask(int id) async {
    await apiService.deleteTodo(id);
    fetchTasks();
  }

  void toggleTaskCompletion(int id, bool completed) async {
    try {
      await apiService.toggleCompletion(id, !completed);
      await fetchTasks(); // Ensure this fetches the updated data
    } catch (e) {
      //print('Error toggling task completion: $e');
    }
  }
}
final taskProvider = StateNotifierProvider<TaskNotifier, List<Todo>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return TaskNotifier(apiService);
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});