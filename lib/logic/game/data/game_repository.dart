import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

class GameRepository {
  GameRepository();
  final dio = Dio();

  late String? accessToken;

  Future<void> getDriveApi() async {
    // Lade die JSON-Datei mit den Anmeldedaten
    String jsonString = await rootBundle.loadString('assets/credentials.json');

    final accountCredentials = ServiceAccountCredentials.fromJson(jsonString);
    const csvContent = "Name,Alter\nAlice,30\nBob,25"; // Beispielinhalt

    var media = Media(
        Stream.fromIterable([utf8.encode(csvContent)]), csvContent.length);

    final scopes = [drive.DriveApi.driveFileScope];

    // Authentifizieren
    final client = await clientViaServiceAccount(accountCredentials, scopes);

    final api = drive.DriveApi(client);
    var fileToUpload = drive.File()
      ..name = "TESTOOO/example.csv"
      ..parents = [
        "1G6lEdX23L-xpfSBkD9WddDvv1AaQoPrh",
      ];

    var uploadedFile = await api.files.create(
      fileToUpload,
      uploadMedia: media,
    );
    print('Datei hochgeladen: ${uploadedFile.id}');
  }
}
