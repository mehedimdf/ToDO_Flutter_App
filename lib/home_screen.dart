import 'package:flutter/material.dart';
import 'custom_task.dart';
import 'custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  List todoList = [];
  int editingIndex = -1;

  // Toggle the checkbox state
  void checkBoxChanged(int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  // Save new task or update the existing task
  void saveTask() {
    setState(() {
      if (editingIndex == -1) {
        // Add new task
        todoList.add([textController.text, false]);
      } else {
        // Update existing task
        todoList[editingIndex][0] = textController.text;
        editingIndex = -1; // Reset editing index
      }
      textController.clear();
    });
  }

  // Delete a task
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  // Start editing a task
  void editTask(int index) {
    setState(() {
      editingIndex = index; // Set the task index being edited
      textController.text = todoList[index][0]; // Populate the controller with the task's text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return CustomTask(
              taskName: todoList[index][0],
              taskCompleted: todoList[index][1],
              onChanged: (value) => checkBoxChanged(index),
              deleteFunction: (value) => deleteTask(index),
              editFunction: (value) => editTask(index), // Edit functionality
            );
          },
        ),
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 10.0),
              child: CustomTextField(
                textEditingController: textController,
                fieldBorderColor: Colors.deepPurple,
                cursorColor: Colors.white,
                hintText: editingIndex == -1
                    ? "Add a new todo item"
                    : "Edit todo item", // Update hint based on editing state
                fillColor: Colors.deepPurple.shade300,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: saveTask,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            backgroundColor: Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}