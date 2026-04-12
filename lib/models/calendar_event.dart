enum CalendarEventType {
  prova('prova', 'Prova'),
  trabalho('trabalho', 'Trabalho'),
  seminario('seminario', 'Seminario'),
  evento('evento', 'Evento'),
  academico('academico', 'academico'),
  pessoal('pessoal', 'Pessoal');

  final String value;
  final String label;

  const CalendarEventType(this.value, this.label);
  static CalendarEventType fromValue(String value) {
    return CalendarEventType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CalendarEventType.pessoal,
    );
  }
}

enum TurmaEnum {
  ads1('es1', 'ES - 1º Ano'),
  ads2('es2', 'ES - 2º Ano'),
  ads3('es3', 'ES - 3º Ano'),
  ads4('es4', 'ES - 4º Ano');

  final String value;
  final String label;

  const TurmaEnum(this.value, this.label);

  static TurmaEnum fromValue(String value) {
    return TurmaEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TurmaEnum.ads1,
    );
  }
}

class CalendarEvent {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final CalendarEventType type;
  final TurmaEnum? course;
  final String authorId;
  final String authorName;
  final bool isPersonal;
  final DateTime createdAt;
  final DateTime updatedAt;

  CalendarEvent({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.type,
    this.course,
    required this.authorId,
    required this.authorName,
    required this.isPersonal,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Transforma o objeto em um Map (JSON)
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'type': type.value,
    'course': course?.value,
    'authorId': authorId,
    'authorName': authorName,
    'isPersonal': isPersonal,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  /// Cria um objeto a partir de um Map (JSON)
  factory CalendarEvent.fromJson(Map<String, dynamic> json) => CalendarEvent(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    date: DateTime.parse(json['date'] as String),
    type: CalendarEventType.fromValue(json['type'] as String),
    course: json['course'] != null
        ? TurmaEnum.fromValue(json['course'] as String)
        : null,
    authorId: json['authorId'] as String,
    authorName: json['authorName'] as String,
    isPersonal: json['isPersonal'] as bool,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  /// Quando um dado é atualizado muda o componente para as novas informações sem precisar buscar no banco para a atualização
  CalendarEvent copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    CalendarEventType? type,
    TurmaEnum? course,
    String? authorId,
    String? authorName,
    bool? isPersonal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CalendarEvent(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    date: date ?? this.date,
    type: type ?? this.type,
    course: course ?? this.course,
    authorId: authorId ?? this.authorId,
    authorName: authorName ?? this.authorName,
    isPersonal: isPersonal ?? this.isPersonal,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
