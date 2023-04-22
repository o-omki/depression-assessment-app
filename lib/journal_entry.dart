class JournalEntry {
  late final String entryId;
  late DateTime date;
  late String mood;
  late final String title;
  late final String content;

  JournalEntry({
    required this.entryId,
    required this.date,
    required this.mood,
    required this.title,
    required this.content,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> jsonData) {
    return JournalEntry(
      entryId: jsonData["entryId"],
      date: jsonData["date"],
      mood: jsonData["mood"],
      title: jsonData["title"],
      content: jsonData["content"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "entryId": entryId,
      "date": date.toIso8601String(),
      "mood": mood,
      "title": title,
      "content": content,
    };
  }
}