import 'package:flutter/material.dart';
import 'package:test3/model/TodoModel.dart';

const Title = 'TODOタスクを追加';

// リスト追加用画面
class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddState createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAddPage> {
  String _todoText = '';

  TodoModel _todoModel = TodoModel('', false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Title),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_todoText, style: TextStyle(color: Colors.orange)),
            const SizedBox(height: 8),
            TextField(
                decoration: InputDecoration(hintText: "TODOを入力"),
                onChanged: (String value) {
                  setState(() {
                    _todoText = value;
                  });
                }),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_todoText != "") {
                    _todoModel.todoTitle = _todoText;
                    _todoModel.isCheckd = false;
                    Navigator.of(context).pop(_todoModel);
                  } else {
                    setState(() {
                      _todoText = 'TODOを入力してください';
                    });
                  }
                },
                child: Text('保存', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
