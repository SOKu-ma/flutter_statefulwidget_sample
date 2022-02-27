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
      body: ListView.builder(
        itemCount: _todoListModel.todoListModel.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_todoListModel.todoListModel[index].todoTitle),
              trailing: Checkbox(
                onChanged: (value) {
                  setState(() {
                    _todoListModel.todoListModel[index].isCheckd =
                        _todoListModel.todoListModel[index].isCheckd
                            ? false
                            : true;
                  });
                },
                value: _todoListModel.todoListModel[index].isCheckd,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("TODOタスクを変更"),
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
                              _todoListModel.todoListModel[index].todoTitle =
                                  _textFieldController.text;
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
          );
        },
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
