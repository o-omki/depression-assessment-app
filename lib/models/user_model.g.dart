// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String,
      lastName: json['last_name'] as String,
      age: json['age'] as int,
      sex: json['sex'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      profilePicture: json['profile_picture'] as String,
      programme: json['programme'] as String,
      year: json['year'] as int,
      emergencyNumber: json['emergency_number'] as String,
      createdAt: User._dateTimeFromTimestamp(json['created_at'] as int),
      lastActiveAt: User._dateTimeFromTimestamp(json['last_active_at'] as int),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'age': instance.age,
      'sex': instance.sex,
      'address': instance.address,
      'profile_picture': instance.profilePicture,
      'programme': instance.programme,
      'year': instance.year,
      'emergency_number': instance.emergencyNumber,
      'created_at': instance.createdAt.toIso8601String(),
      'last_active_at': instance.lastActiveAt.toIso8601String(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zip: json['zip'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
    };
