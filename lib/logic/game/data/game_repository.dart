import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:shadow_deals/core/helpers.dart';
import 'package:shadow_deals/logic/game/models/post_questions_model.dart';
import 'package:shadow_deals/logic/game/models/profile_model.dart';

class GameRepository {
  GameRepository();
  final dio = Dio();

  late String? accessToken;

  Future<void> getDriveApi(
    ProfileModel profile,
    PostQuestionsModel postQuestions,
    List<List<dynamic>> history,
    int playerScore,
    int cpuScore,
    String usedStrategy,
    bool usePlayerTerm,
  ) async {
    // Lade die JSON-Datei mit den Anmeldedaten
    String jsonString = await rootBundle.loadString('assets/credentials.json');

    final accountCredentials = ServiceAccountCredentials.fromJson(jsonString);
    final String csvContent = createCsv(profile, postQuestions, history,
        playerScore, cpuScore, usedStrategy, usePlayerTerm); // Beispielinhalt

    var media = Media(
        Stream.fromIterable([utf8.encode(csvContent)]), csvContent.length);

    DateTime time = DateTime.now();
    String fiileName =
        '${profile.name} ${time.day}_${time.month}_${time.year} ${time.hour}_${time.minute}_${time.second}.csv';

    final scopes = [drive.DriveApi.driveFileScope];

    // Authentifizieren
    final client = await clientViaServiceAccount(accountCredentials, scopes);

    final api = drive.DriveApi(client);
    var fileToUpload = drive.File()
      ..name = fiileName
      ..parents = [
        "1G6lEdX23L-xpfSBkD9WddDvv1AaQoPrh",
      ];

    await api.files.create(
      fileToUpload,
      uploadMedia: media,
    );
  }

  String createCsv(
    ProfileModel profile,
    PostQuestionsModel postQuestions,
    List<List<dynamic>> history,
    int playerScore,
    int cpuScore,
    String usedStrategy,
    bool usePlayerTerm,
  ) {
    final csvBuffer = StringBuffer();
    final double playerAverage = playerScore / history.length;
    final double cpuAverage = cpuScore / history.length;

    // Kopfzeile für Profil, Post-Questions und `usedStrategy`
    csvBuffer.writeln([
      'Spielername',
      'Alter',
      'Anrede',
      'Berufserfahrung',
      'Beruf',
      'Schon gespielt',
      'Spielverständnis',
      'Schwierigkeiten',
      'Durchschnitt',
      'Spieler Strategie',
      'Sp. Strategie Begründung',
      'Dealer analysiert',
      'Dealer Strategie',
      'Wurde Spieler beeinflusst',
      'Spieler Leistung',
      'Vorschläge',
      'Anmerkungen',
      'Genutzte Strategie',
      'Spielerbegriff'
    ].join(',')); // Überschriften

    // Werte für Profil, Post-Questions und `usedStrategy`
    csvBuffer.writeln([
      profile.name,
      profile.age,
      profile.salutation,
      profile.yearsOfExperience,
      profile.jobTitle,
      profile.gamePlayed,
      postQuestions.understanding,
      postQuestions.struggles,
      'Spieler $playerAverage | CPU $cpuAverage',
      postQuestions.cooperations,
      postQuestions.decisions,
      postQuestions.enemyAnalytic,
      postQuestions.enemyStrategy,
      postQuestions.enemyDidManipulate,
      postQuestions.performance,
      postQuestions.optimization,
      postQuestions.suggestions,
      usedStrategy,
      mapUsePlayerTermn(usePlayerTerm),
    ].join(',')); // Werte

    // Leere Zeilen
    csvBuffer.writeln('');
    csvBuffer.writeln('');

    // Überschrift für History mit zusätzlichen Platzhaltern
    csvBuffer.writeln([
      'Runde',
      'Spielerzug',
      'Dealerzug',
      'Spielerpunkte',
      'Dealerpunkte',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X'
    ].join(',')); // Überschriften

    // Werte für History mit zusätzlichen Platzhaltern
    for (int i = 0; i < history.length; i++) {
      final round = history[i];
      final playerMove = round[0]; // Spielerzug
      final cpuMove = round[1]; // Dealerzug
      final scores = round[2] as List; // Punkteliste
      final playerRoundScore = scores[0]; // Spielerpunkte
      final cpuRoundScore = scores[1]; // Dealerpunkte

      csvBuffer.writeln([
        i + 1, // Runde
        playerMove, // Spielerzug
        cpuMove, // Dealerzug
        playerRoundScore, // Spielerpunkte
        cpuRoundScore, // Dealerpunkte
        'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'
      ].join(',')); // Werte für die Runde
    }

    // Leere Zeile als Trennung
    csvBuffer.writeln('');

    // Gesamtpunkte-Zeile mit zusätzlichen Platzhaltern
    csvBuffer.writeln([
      'Gesamt Spieler:',
      playerScore,
      'X',
      'Gesamt Dealer:',
      cpuScore,
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X',
      'X'
    ].join(','));

    return csvBuffer.toString();
  }
}
