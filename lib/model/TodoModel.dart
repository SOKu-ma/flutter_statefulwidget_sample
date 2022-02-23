// Todoモデル
class TodoModel {
  String todoTitle; // タイトル
  bool isCheckd; // チェックFlg

  TodoModel(this.todoTitle, this.isCheckd);
}

// Todoモデルをリストで利用
class TodoListModel {
  List<TodoModel> todoListModel = [];
}
