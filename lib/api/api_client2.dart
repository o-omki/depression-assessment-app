import "package:mongo_dart/mongo_dart.dart";
import "package:serenity_space/journal_entry.dart";

class MongoDBService {
  late Db _db;

  MongoDBService(String url) {
    _db = Db(url);
  }

  Future<void> open() async {
    await _db.open();
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<void> insertOne(String collection, Map<String, dynamic> document) async {
    await _db.collection(collection).insertOne(document);
  }

  Future<void> updateOne(String collection, Map<String, dynamic> document) async {
    await _db.collection(collection).updateOne(document);
  }

  Future<void> deleteOne(String collection, Map<String, dynamic> document) async {
    await _db.collection(collection).deleteOne(document);
  }

  Future<List<Map<String, dynamic>>> find(String collection, Map<String, dynamic> query) async {
    final cursor = _db.collection(collection).find(query);
    final results = await cursor.toList();
    // return results.map((e) => e as Map<String, dynamic>).toList();
    List<JournalEntry> entries = results.map((json) => JournalEntry.fromJson(json)).toList();
  }

}