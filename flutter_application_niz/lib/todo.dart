class ToDo {
  final int? id;
  final String title;
  final bool isFinish;

  ToDo({
    this.id,
    required this.title,
    required this.isFinish,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'is_finish': isFinish ? 1 : 0,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      isFinish: map['is_finish'] == 1,
    );
  }
}
