# 📁 Datenexport des Spiels

Nachdem das Spiel und der Fragebogen abgeschlossen sind, wird ein Datenexport durchgeführt, um die Spielinformationen für wissenschaftliche Analysen zu speichern. Dieser Abschnitt beschreibt, wie der Datenexport organisiert ist und welche Schritte involviert sind, um die Daten auf Google Drive zu speichern.

## 🔄 Start des Datenexports: `UploadResults` Event

Beim Speichern des Fragebogens wird das Event **UploadResults** gestartet, um die Ergebnisse und alle relevanten Daten zu exportieren. Im **GameBloc** wird daraufhin die Methode `_uploadResults` ausgeführt, um den Export durchzuführen:

```dart
on<UploadResults>(_uploadResults);
```

In dieser Methode wird auf das **GameRepository** zugegriffen, das sich unter `lib/logic/game/data/` befindet. Dieses Repository kümmert sich um die eigentliche Handhabung des Datenexports.

### 1. **Verbindung zu Google Drive herstellen**

Der erste Schritt in der Exportlogik ist der Zugriff auf Google Drive. Dazu wird die Datei `credentials.json` benötigt, die die Logindaten für die Cloud enthält:

```dart
String jsonString = await rootBundle.loadString('assets/credentials.json');
```

> **Hinweis**: Diese Datei ist **nicht** in der Git-Repository enthalten, sondern nur auf dem Live-Server vorhanden. Entwickler können beim Owner eine gültige Datei anfordern, um den Datenexport lokal zu testen.

### 2. **Erstellung der CSV-Datei (`createCsv()`)**

Nachdem die Verbindung hergestellt wurde, wird eine **CSV-Datei** erstellt, die alle relevanten Spielinformationen enthält. Die Erstellung erfolgt in mehreren Schritten:

#### a. **Kopfzeile für Profildaten und Fragebogen**

Zuerst wird eine Kopfzeile für die Profildaten und den Fragebogen generiert:

```dart
csvBuffer.writeln([
  'Spielername',
  'Alter',
  'Anrede',
  'Berufserfahrung',
  'Beruf',
  'Schon gespielt',
  'Spielverständnis',
  'Schwierigkeiten',
  'Fairness',
  'Spieler Strategie',
  'Sp. Strategie Begründung',
  'Dealer analysiert',
  'Dealer Strategie',
  'Wurde Spieler beeinflusst',
  'Spieler Leistung',
  'Vorschläge',
  'Anmerkungen',
  'Genutzte Strategie'
].join(','));
```

Diese Kopfzeile umfasst die wichtigsten Kategorien, die die Spielerinformationen und die Ergebnisse des Fragebogens beschreiben.

#### b. **Eintragen der Werte**

Anschließend werden die tatsächlichen Werte des Profils und der Antworten des Fragebogens in die CSV-Datei geschrieben. Diese Werte werden in einer ähnlichen Struktur wie die Kopfzeile hinzugefügt, um sicherzustellen, dass alle Daten vollständig erfasst sind.

#### c. **Kopfzeile für die Rundenhistorie**

Nach zwei Leerzeilen wird eine weitere Kopfzeile hinzugefügt, die sich auf die **Rundenhistorie** bezieht:

```dart
csvBuffer.writeln([
  'Runde',
  'Spielerzug',
  'Dealerzug',
  'Spielerpunkte',
  'Dealerpunkte',
  'X', 'X', 'X', 'X', 'X',
  'X', 'X', 'X', 'X', 'X',
  'X', 'X', 'X'
].join(','));
```

Die `X`-Einträge dienen hier als **Platzhalter**, um sicherzustellen, dass die CSV-Datei keine leeren Zellen hat, die zu Parsing-Problemen führen könnten. Das sorgt für eine bessere Lesbarkeit und verhindert Fehlinterpretationen der Datei.

#### d. **Erstellen der Rundeninformationen**

Für jede Runde wird dann der Inhalt gesetzt. In einer Schleife werden die Daten für die Entscheidungen des Users und der CPU sowie die erzielten Punkte geschrieben:

```dart
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
    'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'
  ].join(','));
}
```

Auch hier werden Platzhalter verwendet, um die Formatierung der CSV-Datei beizubehalten.

#### e. **Gesamtergebnisse**

Nach der Rundenhistorie wird das **Gesamtergebnis** hinzugefügt:

```dart
csvBuffer.writeln([
  'Gesamt Spieler:',
  playerScore,
  'X',
  'Gesamt Dealer:',
  cpuScore,
  'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'
].join(','));
```

Diese Zeile fasst die Gesamtpunktzahl von User und CPU zusammen und gibt damit eine abschließende Übersicht über den Ausgang des Spiels.

### 3. **Hochladen der CSV-Datei zu Google Drive**

Nachdem die CSV-Datei erstellt wurde, wird ein **Dateiname** zusammengestellt, der den Spielernamen und einen Zeitstempel enthält:

```dart
'${profile.name} ${time.day}_${time.month}_${time.year} ${time.hour}_${time.minute}_${time.second}.csv';
```

Dieser Dateiname sorgt für eine eindeutige Identifikation jeder CSV-Datei, basierend auf dem Spielerprofil und dem Zeitpunkt des Exports.

Anschließend wird die CSV-Datei in Google Drive hochgeladen:

```dart
await api.files.create(
  fileToUpload,
  uploadMedia: media,
);
```

Der Upload stellt sicher, dass die Ergebnisse sicher in der Cloud gespeichert werden und für zukünftige Analysen zur Verfügung stehen.

## 🔄 Zusammenfassung

Der Datenexport ist ein essenzieller Teil des Spiels, der sicherstellt, dass alle relevanten Informationen gespeichert werden. Der Prozess umfasst die Erstellung einer CSV-Datei mit allen Profildaten, Antworten des Fragebogens, der Rundenhistorie und den Gesamtergebnissen. Diese Daten werden dann in Google Drive hochgeladen, wo sie für wissenschaftliche Zwecke weiterverwendet werden können. 🚀
