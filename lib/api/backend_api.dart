import "dart:developer";
import "dart:convert";

import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";
import "../models/appointment_model.dart";
import "../models/journal_model.dart";

String hostIp = dotenv.env["HOST_IP"]!;

Future<void> createJournalEntry(
    String userId, JournalEntry journalEntry) async {
  String url = "$hostIp/serenity/users/$userId/journal";

  // Send the POST request
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(journalEntry.toJson()),
  );

  // Check the response status
  if (response.statusCode == 201) {
    // Journal entry created successfully
    log("Journal entry created successfully");
  } else {
    // Failed to create journal entry
    log("Failed to create journal entry");
    log(response.body);
  }
}

Future<List<Map<String, dynamic>>> getMoodGraphEntries(String userId) async {
  String url = "$hostIp/serenity/users/$userId/journal/mood";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 404) {
    log("No journal entries found");
    return [];
  } else if (response.statusCode == 200) {
    // Journal entries found
    log("Journal entries found");
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Map<String, dynamic>> moodGraphEntries = [];
    for (var entry in jsonResponse) {
      moodGraphEntries.add(entry);
    }
    return moodGraphEntries;
  } else {
    // Failed to get journal entries
    log("Failed to get journal entries");
    return [];
  }
}

Future<List<Map<String, dynamic>>> getCounsellors() async {
  final String url = "$hostIp/serenity/counsellors";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    log("Counsellors found");
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Map<String, dynamic>> counsellors = [];
    for (var entry in jsonResponse) {
      counsellors.add(entry);
    }
    return counsellors;
  } else {
    log("Failed to get counsellors");
    return [];
  }
}

Future<void> createAppointment(AppointmentModel appointment) async {
  final String url = "$hostIp/serenity/appointments";
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode(appointment.toJson());

  final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 201) {
    log('Appointment created successfully');
  } else {
    log('Failed to create appointment');
  }
}

Future<Map<String, dynamic>> fetchUserAppointments(String userId) async {
  final String url = "$hostIp/serenity/users/$userId/appointments";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    log('Appointments found');
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Map<String, dynamic>> completedAppointments = [];
    List<Map<String, dynamic>> upcomingAppointments = [];
    List<Map<String, dynamic>> cancelledAppointments = [];

    for (var entry in jsonResponse) {
      if (entry['status'] == 'completed') {
        completedAppointments.add(entry);
      } else if (entry['status'] == 'upcoming') {
        upcomingAppointments.add(entry);
      } else if (entry['status'] == 'cancelled') {
        cancelledAppointments.add(entry);
      }
    }

    final userAppointments = {
      'completed': completedAppointments,
      'upcoming': upcomingAppointments,
      'cancelled': cancelledAppointments,
    };
    return userAppointments;
  } else {
    log('Failed to get appointments');
    return {};
  }
}

Future<bool> updateAppointment(AppointmentModel appointment) async {
  final String url = "$hostIp/serenity/appointments/${appointment.id}";
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode(appointment.toJson());

  final response = await http.put(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    log('Appointment updated successfully');
    return true;
  } else {
    log('Failed to update appointment');
    return false;
  }
}

Future<bool> checkUserExists(String userId) async {
  log(userId);
  String url = "$hostIp/serenity/users/$userId";

  // Send the GET request
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  log('Response: $response');

  if (response.statusCode == 404) {
    log("User not found");
    return false;
  } else {
    log("User found");
    return true;
  }
}

Future<Map<String, dynamic>> updateUserProfile(
    String userId, Map<String, dynamic> updatedProfile) async {
  String url = "$hostIp/serenity/users/$userId";

  http.Response response = await http.put(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(updatedProfile),
  );

  if (response.statusCode == 200) {
    log("User profile updated successfully");
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    log("Failed to update user profile");
    log(response.body);
    return {};
  }
}
