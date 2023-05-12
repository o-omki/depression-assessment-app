import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  String id;

  String email;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'middle_name')
  String middleName;

  @JsonKey(name: 'last_name')
  String lastName;

  int age;
  String sex;
  Address address;

  @JsonKey(name: 'profile_picture')
  String profilePicture;

  String programme;
  int year;

  @JsonKey(name: 'emergency_number')
  String emergencyNumber;

  @JsonKey(name: 'created_at', fromJson: _dateTimeFromTimestamp)
  DateTime createdAt;

  @JsonKey(name: 'last_active_at', fromJson: _dateTimeFromTimestamp)
  DateTime lastActiveAt;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.age,
    required this.sex,
    required this.address,
    required this.profilePicture,
    required this.programme,
    required this.year,
    required this.emergencyNumber,
    required this.createdAt,
    required this.lastActiveAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime _dateTimeFromTimestamp(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

@JsonSerializable()
class Address {
  String street;
  String city;
  String state;
  String zip;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
