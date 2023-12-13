class TaskModel {
  final int id;
  final int type;

  // General information
  final String title;
  final String description;
  final int idPicto;

  // Task elements
  List<TaskElement> elements = [];

  // Constructor
  TaskModel(
      {required this.id,
      required this.type,
      required this.title,
      required this.description,
      required this.idPicto});

  // Factory method that creates an User instance from a JSON
  factory TaskModel.fromJSON(Map<String, dynamic> json, int type) {
    return TaskModel(
        id: json['id'] as int,
        type: type,
        title: json['title'] as String,
        description: json['desc'] as String,
        idPicto: json[''] as int);
  }

  // Method that adds a new element to the element list
  void addElement(TaskElement element) {
    elements.add(element);
  }
}

class TaskElement {}

class Step extends TaskElement {
  final String description;
  final String media;
  final int stepNumber;

  Step(
      {required this.description,
      required this.media,
      required this.stepNumber});
}

class TaskItem extends TaskElement {
  final int id;
  final int quantity;

  TaskItem({required this.id, required this.quantity});
}
