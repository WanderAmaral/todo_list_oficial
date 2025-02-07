import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Gerenciador de Tarefas")),
      body: taskController.tasks.isEmpty
          ? Center(child: Text("Nenhuma tarefa adicionada"))
          : ListView.builder(
              itemCount: taskController.tasks.length,
              itemBuilder: (context, index) {
                Task task = taskController.tasks[index];

                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Checkbox(
                    value: task.completed,
                    onChanged: (value) {
                      taskController.updateTask(
                        Task(
                          id: task.id,
                          title: task.title,
                          description: task.description,
                          completed: value ?? false,
                          createdAt: task.createdAt,
                        ),
                      );
                    },
                  ),
                  onTap: () =>
                      _showEditTaskDialog(context, taskController, task),
                  onLongPress: () =>
                      _confirmDelete(context, taskController, task.id!),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, taskController),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditTaskDialog(
      BuildContext context, TaskController taskController, Task task) {
    TextEditingController titleController =
        TextEditingController(text: task.title);
    TextEditingController descriptionController =
        TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar Tarefa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Título")),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Descrição")),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
          TextButton(
            onPressed: () {
              taskController.updateTask(Task(
                id: task.id,
                title: titleController.text,
                description: descriptionController.text,
                completed: task.completed,
                createdAt: task.createdAt,
              ));
              Navigator.pop(context);
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskController taskController) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Nova Tarefa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Título")),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Descrição")),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
          TextButton(
            onPressed: () {
              taskController.addTask(Task(
                title: titleController.text,
                description: descriptionController.text,
                completed: false,
                createdAt: DateTime.now(),
              ));
              Navigator.pop(context);
            },
            child: Text("Adicionar"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, TaskController taskController, int taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Excluir Tarefa"),
        content: Text("Tem certeza que deseja excluir esta tarefa?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
          TextButton(
            onPressed: () {
              taskController.deleteTask(taskId);
              Navigator.pop(context);
            },
            child: Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
