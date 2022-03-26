import 'package:flutter/material.dart';
import 'package:test3/model/TodoModel.dart';
import 'package:test3/ui/add_todo/add_todo_page.dart';

const Title = 'TODO一覧';

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  TodoListModel _todoListModel = TodoListModel();

  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Title),
      ),
      body: ReorderableListView(
        onReorder: ((oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final TodoModel _todo =
                _todoListModel.todoListModel.removeAt(oldIndex);
            _todoListModel.todoListModel.insert(newIndex, _todo);
          });
        }),
        children: [
          for (final todo in _todoListModel.todoListModel)
            Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete),
              ),
              child: Card(
                child: ListTile(
                  title: Text(todo.todoTitle),
                  trailing: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        todo.isCheckd = todo.isCheckd ? false : true;
                      });
                    },
                    value: todo.isCheckd,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("タスクを変更"),
                          content: TextField(
                            controller: _textFieldController,
                            decoration: InputDecoration(
                              hintText: "タスクを入力",
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  _textFieldController.text = "";
                                  Navigator.pop(context);
                                }),
                            ElevatedButton(
                              child: Text("OK"),
                              onPressed: () {
                                setState(() {
                                  if (_textFieldController.text != "") {
                                    todo.todoTitle = _textFieldController.text;
                                  }
                                  _textFieldController.text = "";
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final _todo = await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return TodoAddPage();
            },
          ));
          if (_todo != null) {
            setState(() {
              _todoListModel.todoListModel.add(_todo);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
