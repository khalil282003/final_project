import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/task.dart';
import '../providers/task_provider.dart';
import 'login_page.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskProvider.notifier);
    final _controller = TextEditingController();

    void saveNewTask() {
      if (_controller.text.trim().isNotEmpty) {
        taskNotifier.addTask(_controller.text);
        _controller.clear();
        FocusScope.of(context).unfocus(); // Dismiss keyboard
      }
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: const Text('Simple Todo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              taskNotifier.clearTasks(); // Clear tasks on logout
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LogIn(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
        future: taskNotifier.fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final tasks = ref.watch(taskProvider);
            return Column(
              children: [
                Expanded(
                  child: tasks.isEmpty
                      ? const Center(child: Text('No tasks available.'))
                      : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, index) {
                      final task = tasks[index];
                      return Task(
                        taskName: task.title,
                        //taskCompleted: task.completed,
                        onChanged: (value) =>
                            taskNotifier.toggleTaskCompletion(
                                task.id, task.completed),
                        deleteFunction: (context) =>
                            taskNotifier.removeTask(task.id),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Add a new todo item',
                            filled: true,
                            fillColor: Colors.deepPurple.shade200,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        onPressed: saveNewTask,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_helper.dart';
import '../components/task.dart';
import '../providers/task_provider.dart';
import 'login_page.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final taskNotifier = ref.read(taskProvider.notifier);
    final _controller = TextEditingController();

    void saveNewTask() {
      if (_controller.text.trim().isNotEmpty) {
        taskNotifier.addTask(_controller.text);
        _controller.clear();
        FocusScope.of(context).unfocus(); // Dismiss keyboard
      }
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: const Text('Simple Todo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              taskNotifier.clearTasks(); // Clear tasks on logout
              AppHelper.storeToken('');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LogIn(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text('No tasks available.'))
                : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, index) {
                final task = tasks[index];
                return Task(
                  taskName: task.title,
                  taskCompleted: task.completed,
                  onChanged: (value) => taskNotifier.toggleTaskCompletion(task.id, task.completed),
                  deleteFunction: (context) => taskNotifier.removeTask(task.id),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      filled: true,
                      fillColor: Colors.deepPurple.shade200,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: saveNewTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

*/

/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../app_helper.dart';
import '../components/task.dart';
import '../models/todo_model.dart';
import '../providers/task_provider.dart';
import 'login_page.dart';

class TasksPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final taskNotifier = ref.read(taskProvider.notifier);
    final _controller = TextEditingController();
    void saveNewTask() {
      if (_controller.text.trim().isNotEmpty) {
        taskNotifier.addTask(_controller.text);
        _controller.clear();
      }
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: const Text('Simple Todo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            AppHelper.storeToken('');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LogIn(),
              ),
            );
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, index) {
          final task = tasks[index];
          return Task(
            taskName: task.title,
            taskCompleted: task.completed,
            onChanged: (value) => taskNotifier.toggleTaskCompletion(task.id, task.completed),
            deleteFunction: (context) => taskNotifier.removeTask(task.id),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new todo item',
                    filled: true,
                    fillColor: Colors.deepPurple.shade200,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}*/
