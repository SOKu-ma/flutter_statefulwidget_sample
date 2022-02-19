import 'package:flutter/material.dart';
import 'package:test3/model/TodoModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上に表示される"debug"ラベルを消す
      debugShowCheckedModeBanner: false,
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListPage(),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _title = 'リスト一覧';
  TodoListModel _todoListModel = TodoListModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
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
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final _todo = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
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

// リスト追加用画面
class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddState createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAddPage> {
  String _title = 'リスト追加';
  String _text = '';

  TodoModel _todoModel = TodoModel('', false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text, style: TextStyle(color: Colors.orange)),
            const SizedBox(height: 8),
            TextField(onChanged: (String value) {
              setState(() {
                _text = value;
              });
            }),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_text != "") {
                    _todoModel.todoTitle = _text;
                    _todoModel.isCheckd = true;
                    Navigator.of(context).pop(_todoModel);
                  } else {
                    setState(() {
                      _text = 'TODOを入力してください';
                    });
                  }
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
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
