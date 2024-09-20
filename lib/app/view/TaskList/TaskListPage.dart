import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listas_tareas/app/model/task.dart';
import 'package:listas_tareas/app/repository/task_repository.dart';
import 'package:listas_tareas/app/view/TaskList/TaskProvider.dart';
import 'package:listas_tareas/app/view/components/TitlePerson.dart';
import 'package:listas_tareas/app/view/components/shape.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListPage  extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..fetchTasks(),
      child: Scaffold(
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Header(),
            Expanded(
              child: _TaskList()),
          ],
        ),
        floatingActionButton: Builder (
          builder: (context) => FloatingActionButton(
              onPressed: () => _showNewTaskModal(context),
              child: const Icon(Icons.add, size:50)
          ),
        ),
      )
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ChangeNotifierProvider.value(
          value: context.read<TaskProvider>(),
          child: _NewTaskModal(),
        ),
    );
  }
}

class _NewTaskModal extends StatelessWidget{
  _NewTaskModal({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:33, vertical:23)+
        MediaQuery.of(context).viewInsets,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        color: Colors.white,
      ),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TitlePerson('Nueva tarea'),
          const SizedBox(height:26),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              filled:true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              ),
              hintText: 'Descripción de la tarea',
            ),
          ),
          const SizedBox(height:26),
          ElevatedButton(
              onPressed: (){
                if (_controller.text.isNotEmpty) {
                  final task = Task(_controller.text);
                  context.read<TaskProvider>().addNewTask(task);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar')
          )
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.symmetric(horizontal:30,vertical:25),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitlePerson('Tareas'),
          const SizedBox(height:13),
          Expanded (
            child: Consumer<TaskProvider> (
              builder: (_,provider,__) {
                if(provider.taskList.isEmpty) {
                  return const Center (
                    child: Text('No hay tareas'),
                  );
                }
                return ListView.separated(
                    itemBuilder: (_,index) => _TaskItem(
                      provider.taskList[index],
                      onTap: () => provider.onTaskDoneChange(provider.taskList[index]),
                    ),
                    separatorBuilder: (_,__) => const SizedBox(height:16),
                    itemCount: provider.taskList.length
                );
              }
            ),
          ),
        ],
      )
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          const Row(children: [
            Shape()
          ]),
          Column(
            children: [
              Image.asset(
                'assets/image/tasks-list-image.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height:16),
              const TitlePerson('Completa tus tareas',color:Colors.white),
              const SizedBox(height:16),
            ],
          )
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(this.task, {super.key, this.onTap});

  final Task task;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          child: Padding (
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Icon(
                    task.done ? Icons.check_box_rounded : Icons.check_box_outline_blank,
                    color: Theme.of(context).colorScheme.primary
                ),
                const SizedBox(width:10),
                Text(task.title),
              ],
            ),
          )
      )
    );
  }
}
