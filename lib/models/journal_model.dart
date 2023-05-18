import 'package:json_annotation/json_annotation.dart';

part 'journal_model.g.dart';

@JsonSerializable()
class JournalModel {
  @JsonKey(name: '_id')
  String id;

  List<JournalEntry> journalEntries;

  JournalModel({
    required this.id,
    required this.journalEntries,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) =>
      _$JournalModelFromJson(json);
  Map<String, dynamic> toJson() => _$JournalModelToJson(this);
}

@JsonSerializable()
class JournalEntry {
  DateTime date;
  String description;

  @JsonKey(name: 'mood_value')
  String moodValue;

  @JsonKey(name: 'mood_score')
  double moodScore;

  JournalEntry({
    required this.date,
    required this.description,
    required this.moodValue,
    required this.moodScore,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);
  Map<String, dynamic> toJson() => _$JournalEntryToJson(this);
}
