import "package:flutter/material.dart";

import "../api_client.dart";
import "../journal_entry.dart";

class JournalProvider with ChangeNotifier {
  List<JournalEntry> _journalEntries = [];
  List<JournalEntry> get journalEntries => _journalEntries;

  Future<void> fetchJournalEntries() async {
    try {
      _journalEntries = await APIClient.fetchJournalEntires();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> addJournalEntry(JournalEntry journalEntry) async {
    try {
      await APIClient.addJournalEntry(journalEntry);
      _journalEntries.insert(0, journalEntry);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> deleteJournalEntry(JournalEntry journalEntry) async {
    try {
      await APIClient.deleteJournalEntry(journalEntry);
      _journalEntries.remove(journalEntry);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> updateJournalEntry(JournalEntry journalEntry) async {
    try {
      await APIClient.updateJournalEntry(journalEntry);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}