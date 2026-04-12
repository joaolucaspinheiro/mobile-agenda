enum AppDay {
  segunda('segunda', 'Segunda-feira'),
  terca('terca', 'Terça-feira'),
  quarta('quarta', 'Quarta-feira'),
  quinta('quinta', 'Quinta-feira'),
  sexta('sexta', 'Sexta-feira'),
  sabado('sabado', 'Sabado'),
  domingo('domingo', 'Domingo');

  final String value;
  final String label;

  const AppDay(this.value, this.label);

  static AppDay fromValue(String value) {
    return AppDay.values.firstWhere(
      (d) => d.value == value,
      orElse: () => AppDay.segunda,
    );
  }
}

class ClassSchedule {
  final String id;
  final AppDay dayOfWeek;
  final String startTime;
  final String endTime;
  final String subject;
  final String professor;
  final String room;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClassSchedule({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.professor,
    required this.room,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'dayOfWeek': dayOfWeek.value,
    'startTime': startTime,
    'endTime': endTime,
    'subject': subject,
    'professor': professor,
    'room': room,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
  factory ClassSchedule.fromJson(Map<String, dynamic> json) => ClassSchedule(
    id: json['id'] as String,
    dayOfWeek: AppDay.fromValue(json['dayOfWeek'] as String),
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    subject: json['subject'] as String,
    professor: json['professor'] as String,
    room: json['room'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  ClassSchedule copyWith({
    String? id,
    AppDay? dayOfWeek,
    String? startTime,
    String? endTime,
    String? subject,
    String? professor,
    String? room,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ClassSchedule(
    id: id ?? this.id,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    subject: subject ?? this.subject,
    professor: professor ?? this.professor,
    room: room ?? this.room,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
