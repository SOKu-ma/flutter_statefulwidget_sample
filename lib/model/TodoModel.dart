class TodoModel {
  String todoTitle;
  bool isCheckd;

  TodoModel(
    this.todoTitle,
    this.isCheckd,
  );
}

class TodoListModel {
  List<TodoModel> todoListModel = [];
}
