class AppointmentEntry {
  final String id;
  final String userId;
  final String counsellorId;
  final bool confirmed;
  final String status;
  final DateTime appointmentDate;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppointmentEntry({
    required this.id,
    required this.userId,
    required this.counsellorId,
    required this.confirmed,
    required this.status,
    required this.appointmentDate,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppointmentEntry.fromJson(Map<String, dynamic> json) {
    return AppointmentEntry(
      id: json['_id'] ?? "",
      userId: json['user_id'],
      counsellorId: json['counsellor_id'],
      confirmed: json['confirmed'],
      status: json['status'],
      appointmentDate: DateTime.parse(json['appointment_date']),
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'counsellor_id': counsellorId,
      'confirmed': confirmed,
      'status': status,
      'appointment_date': appointmentDate.toIso8601String(),
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
