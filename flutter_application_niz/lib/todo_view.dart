import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key}); // Key を追加

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late List<ToDo> _todoList;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _todoList = [];
    _fetchToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add ToDo',
        child: const Icon(Icons.add),
      ),
    );
  }

  // floatingActionButtonが押された時に表示するToDo追加ページ
  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add a new ToDo'),
            ),
            body: TextField(
              autofocus: true,
              onSubmitted: (val) {
                ToDo newTodo = ToDo(title: val, isFinish: false);
                _insertToDo(newTodo);
                Navigator.pop(context);
              },
              decoration: const InputDecoration(
                  hintText: 'Input a new ToDo title.',
                  contentPadding: EdgeInsets.all(16.0)),
            ),
          );
        },
      ),
    );
  }

  // ToDoListの作成
  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoList.length,
      itemBuilder: (context, index) {
        ToDo todo = _todoList[index];
        return Card(
          child: ListTile(
            title: Text(todo.title),
            leading: Checkbox(
              onChanged: (value) {
                ToDo updatedTodo =
                    ToDo(id: todo.id, title: todo.title, isFinish: value!);
                _updateToDo(updatedTodo);
              },
              value: todo.isFinish,
            ),
            trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteToDo(todo);
                }),
          ),
        );
      },
    );
  }

  // データベースの内容をページに反映
  _fetchToDoList() async {
    List<Map<String, dynamic>> result = await dbHelper.getAllData();
    setState(() {
      _todoList = result.map((map) => ToDo.fromMap(map)).toList();
    });
  }

  _insertToDo(ToDo todo) async {
    await dbHelper.insertData(todo.toMap());
    _fetchToDoList();
  }

  _updateToDo(ToDo todo) async {
    await dbHelper.updateData(todo.id!, todo.toMap());
    _fetchToDoList();
  }

  _deleteToDo(ToDo todo) async {
    await dbHelper.deleteData(todo.id!);
    _fetchToDoList();
  }
}
