// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalModel _$JournalModelFromJson(Map<String, dynamic> json) => JournalModel(
      id: json['_id'] as String,
      journalEntries: (json['journalEntries'] as List<dynamic>)
          .map((e) => JournalEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JournalModelToJson(JournalModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'journalEntries': instance.journalEntries,
    };

JournalEntry _$JournalEntryFromJson(Map<String, dynamic> json) => JournalEntry(
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      moodValue: json['mood_value'] as String,
      moodScore: (json['mood_score'] as num).toDouble(),
    );

Map<String, dynamic> _$JournalEntryToJson(JournalEntry instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'mood_value': instance.moodValue,
      'mood_score': instance.moodScore,
    };
