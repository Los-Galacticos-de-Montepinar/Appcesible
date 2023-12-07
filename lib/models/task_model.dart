class TaskModel {
  int id;
  int type; // 0 - Fixed | 1 - Material

  // General information
  String title;
  String description;
  int idPicto;

  // Task elements
  List<TaskElement> elements = [];

  // Constructor
  TaskModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.idPicto
  });

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

  // Method that adds all the elements in a list
  void addElements(List<TaskElement> element) {
    elements.addAll(elements);
  }
}

class TaskElement {}

class Step extends TaskElement {
  final String description;
  final String media;
  final int stepNumber;

  Step({
    required this.description,
    required this.media,
    required this.stepNumber
  });
}

class TaskItem extends TaskElement {
  final int id;
  String name;
  int quantity;

  TaskItem({
    required this.id,
    required this.name,
    required this.quantity
  });
}
