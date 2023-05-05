import "package:mongo_dart/mongo_dart.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "../journal_entry.dart";

class JournalProvider {
  late Db _db;

  JournalProvider() {
    final dbUrl = dotenv.env["MONGODB_URL"]!;
    final dbUser = dotenv.env["MONGODB_USER"]!;
    final dbPassword = dotenv.env['MONGODB_PASSWORD']!;
    final dbDatabase = dotenv.env['MONGODB_DATABASE']!;
    final dbCollection = dotenv.env['MONGODB_COLLECTION']!;
    final dbAuthMechanism = 'SCRAM-SHA-1';

    final dbUri = Uri.parse(dbUrl);
    final dbHost = dbUri.host;
    final dbPort = dbUri.port;
    final dbSsl = dbUri.scheme == "mongodb+srv";

    final dbCredentials = SslOptions
  }
}