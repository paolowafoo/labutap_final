import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add({'title': _taskController.text, 'isDone': false});
        _taskController.clear();
      });
    }
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Add Task',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? Center(child: Text('No tasks added yet!'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              task['title'],
                              style: TextStyle(
                                decoration: task['isDone']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            leading: Checkbox(
                              value: task['isDone'],
                              onChanged: (_) => _toggleTaskStatus(index),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
