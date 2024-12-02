# 🚀 Anleitung: Neue Strategien zum Spiel hinzufügen

Diese Anleitung zeigt dir, wie du eine neue Strategie im UniGame-Projekt hinzufügst. Der Prozess beinhaltet das Hinzufügen des Namens der Strategie, das Definieren einer Wahrscheinlichkeitstabelle, das Aktualisieren der Spiellogik und das Anlegen eines passenden Bildes.

## 1. 🎲 Strategie benennen

Zuerst wird der Name der neuen Strategie im `game_bloc.dart` festgelegt.

- **Regel**: Der Name muss aus zwei Wörtern bestehen und mit "Zen" beginnen, gefolgt von einem zweiten Namen (z.B. `Zen XY`). Alle Strategien folgen diesem Schema.
- **Beispiel**: In der Liste der Strategien könnte der neue Eintrag wie folgt aussehen:
  ```dart
  List<String> strategies = [
    'Zen Shadow',
    'Zen Mind',
    'Zen Dealer',
    'Zen XY' // Neue Strategie
  ];
  ```

## 2. 📊 Wahrscheinlichkeitstabelle anlegen

Nachdem der Name in die Strategieliste aufgenommen wurde, muss eine Wahrscheinlichkeitstabelle für die neue Strategie angelegt werden.

- Die Tabellen befinden sich im gleichen File, **oberhalb der Strategieliste**.
- Jede Strategie erhält eine Wahrscheinlichkeitstabelle, die beschreibt, wie wahrscheinlich die CPU in bestimmten Spielsituationen kooperiert.
- **Notation**: Die Tabelle für `Zen XY` würde z.B. `xyParams` heißen. Die Buchstaben vor den Zahlen stehen für die Entscheidungen der letzten Runde:

  - `'CC'` = Beide haben kooperiert.
  - `'CD'` = Spieler hat kooperiert, CPU hat defektiert.
  - `'DC'` = Spieler hat defektiert, CPU hat kooperiert.
  - `'DD'` = Beide haben defektiert.

- **Beispiel**:
  ```dart
  final Map<String, double> xyParams = {
    "CC": 0.65, // Beide kooperieren
    "CD": 0.2,  // Spieler kooperiert, CPU defektiert
    "DC": 0.5,  // Spieler defektiert, CPU kooperiert
    "DD": 0.1   // Beide defektieren
  };
  ```

## 3. 🔄 Anpassung der Spiellogik

Damit die neue Strategie auch verwendet werden kann, musst du Anpassungen an der Methode `calculateCpuChoice()` vornehmen.

- Im **Switch-Block** wird definiert, welche Parameter für die jeweilige Strategie verwendet werden sollen.
- Füge einen neuen **case** für die neue Strategie hinzu und verlinke die entsprechenden Params:
  ```dart
  switch (usedStrategy) {
    case 'Zen Shadow':
      params = shadowParams;
      break;
    case 'Zen Mind':
      params = mindParams;
      break;
    case 'Zen Dealer':
      params = dealerParams;
      break;
    case 'Zen XY':
      params = xyParams;
      break;
  }
  ```

> **Wichtig**: Achte darauf, dass der Name in der Liste und im **case**-Block identisch ist, um Fehler zu vermeiden.

## 4. 🖼️ Bild für die Strategie hinzufügen

Damit die neue Strategie im Spiel korrekt angezeigt wird, muss ein Bild hinzugefügt werden.

- **Verzeichnis**: Füge das Bild im Ordner `assets/images/` hinzu.
- **Naming Convention**: Der Dateiname muss zur Strategie passen und wird in **Kleinschrift** angegeben.
  - Beispiel: Für die Strategie `Zen XY` sollte die Bilddatei `xy.png` heißen.

> **Hinweis**: Wenn das Programm bzw. der Debugger noch läuft, muss die Flutter-Anwendung neu gestartet werden, damit die Änderungen unter `assets/images/` erkannt werden.

---

Mit diesen vier Schritten kannst du eine neue Strategie erfolgreich hinzufügen. Viel Spaß beim Entwickeln und Testen deiner eigenen Strategien! 🚀🎮
