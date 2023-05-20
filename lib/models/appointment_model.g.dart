// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      userPicture: json['user_picture'] as String,
      confirmed: json['confirmed'] as bool,
      status: json['status'] as String,
      appointmentDate: json['appointment_date'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      counsellorId: json['counsellor_id'] as String,
      counsellorName: json['counsellor_name'] as String,
      counsellorPicture: json['counsellor_picture'] as String,
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_picture': instance.userPicture,
      'confirmed': instance.confirmed,
      'status': instance.status,
      'appointment_date': instance.appointmentDate,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'counsellor_id': instance.counsellorId,
      'counsellor_name': instance.counsellorName,
      'counsellor_picture': instance.counsellorPicture,
    };
