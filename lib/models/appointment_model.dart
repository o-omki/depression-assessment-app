class AppointmentEntry {
  final String id;
  final String userId;
  final String counselorId;
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
    required this.counselorId,
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
      id: json['_id'],
      userId: json['userId'],
      counselorId: json['counselorId'],
      confirmed: json['confirmed'],
      status: json['status'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'counselorId': counselorId,
      'confirmed': confirmed,
      'status': status,
      'appointmentDate': appointmentDate.toIso8601String(),
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

}
