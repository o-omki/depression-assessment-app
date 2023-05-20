import 'package:json_annotation/json_annotation.dart';

part 'appointment_model.g.dart';

@JsonSerializable()
class AppointmentModel {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'user_picture')
  String userPicture;

  bool confirmed;
  String status;

  @JsonKey(name: 'appointment_date')
  String appointmentDate;

  String description;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'counsellor_id')
  String counsellorId;

  @JsonKey(name: 'counsellor_name')
  String counsellorName;

  @JsonKey(name: 'counsellor_picture')
  String counsellorPicture;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPicture,
    required this.confirmed,
    required this.status,
    required this.appointmentDate,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.counsellorId,
    required this.counsellorName,
    required this.counsellorPicture,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}
