import 'dart:convert';

class Unit {
  final String code;
  final String name;
  final String lecturer;
  final String day;
  final String startTime;
  final String endTime;
  final String venue;

  Unit({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.venue,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'lecturer': lecturer,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'venue': venue,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      lecturer: map['lecturer'] ?? '',
      day: map['day'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      venue: map['venue'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));

  Unit copyWith({
    String? code,
    String? name,
    String? lecturer,
    String? day,
    String? startTime,
    String? endTime,
    String? venue,
  }) {
    return Unit(
      code: code ?? this.code,
      name: name ?? this.name,
      lecturer: lecturer ?? this.lecturer,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      venue: venue ?? this.venue,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Unit &&
        other.code == code &&
        other.day == day &&
        other.startTime == startTime;
  }

  @override
  int get hashCode => code.hashCode ^ day.hashCode ^ startTime.hashCode;

  @override
  String toString() {
    return 'Unit(code: $code, name: $name, day: $day, startTime: $startTime)';
  }
}
