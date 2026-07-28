import 'dart:convert';

class Assignment {
  final String id;
  final String unitCode;
  final String title;
  final String description;
  final String dueDate;
  final bool isCompleted;

  Assignment({
    required this.id,
    required this.unitCode,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unitCode': unitCode,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'] ?? '',
      unitCode: map['unitCode'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: map['dueDate'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Assignment.fromJson(String source) =>
      Assignment.fromMap(json.decode(source));

  Assignment copyWith({
    String? id,
    String? unitCode,
    String? title,
    String? description,
    String? dueDate,
    bool? isCompleted,
  }) {
    return Assignment(
      id: id ?? this.id,
      unitCode: unitCode ?? this.unitCode,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Assignment && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
