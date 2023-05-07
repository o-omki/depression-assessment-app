import "package:mongo_dart/mongo_dart.dart";
class AppointmentEntry {
  final String id;
  final String userId;
  final String counsellorId;
  final String counsellorName;
  final String counsellorPicture;
  bool confirmed;
  String status;
  DateTime appointmentDate;
  String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppointmentEntry({
    required this.id,
    required this.userId,
    required this.counsellorId,
    required this.counsellorName,
    required this.counsellorPicture,
    required this.confirmed,
    required this.status,
    required this.appointmentDate,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppointmentEntry.fromJson(Map<String, dynamic> json) {
    return AppointmentEntry(
      id: json['_id'] ?? "",
      userId: json['user_id'],
      counsellorId: json['counsellor_id'],
      counsellorName: json['counsellor_name'],
      counsellorPicture: json['counsellor_picture'],
      confirmed: json['confirmed'],
      status: json['status'],
      appointmentDate: DateTime.parse(json['appointment_date']),
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
      'counsellor_name': counsellorName,
      'counsellor_picture': counsellorPicture,
      'confirmed': confirmed,
      'status': status,
      'appointment_date': appointmentDate.toIso8601String(),
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
