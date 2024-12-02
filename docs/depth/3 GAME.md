# 🕹️ Start des Spiels: Anzeige und Logik

Nachdem der User sein Profil angelegt hat, startet das Spiel in der **GamePage**. Hier wird der Hauptteil des Spiels dargestellt, der die Interaktionen zwischen dem User und dem CPU-Gegner visualisiert. Dieser Abschnitt beschreibt, was im UI und in der Logik passiert, wenn das Spiel gestartet wird.

## 📄 Aufbau der GamePage (`_buildBody`)

Die **GamePage** zeigt dem User Informationen zu seinem Profil, dem Gegner und der aktuellen Spielsituation. Folgende Komponenten sind entscheidend:

### 1. **Profil- und Gegnerbild**

- **Spielerprofil**: Ein (statisches) Bild für den Spieler und der eingegebene Name werden prominent angezeigt, um die Spielidentität hervorzuheben.
- **Gegnerbild**: Das Bild des Gegners wird abhängig von der gewählten Strategie dynamisch geladen:
  ```dart
  'assets/images/${state.usedStrategy.split(' ').last.toLowerCase()}.png'
  ```
  Diese Logik sorgt dafür, dass die grafische Darstellung des Gegners entsprechend der gewählten CPU-Strategie variiert.

### 2. **Rundenanzeige**

- Die **Gesamtanzahl der Runden** wird ebenfalls auf der GamePage angezeigt. Dies dient der Orientierung des Users und gibt Aufschluss darüber, wie viele Runden noch zu spielen sind.
- **Ergebnisse der letzten Runde**: Falls es nicht die erste Runde ist, werden auch die Ergebnisse der vorherigen Runde angezeigt. Dies erfolgt nur, wenn alle relevanten Daten (`prevCpuChoice`, `prevScores`) vorhanden und der Ladezustand (`isLoading`) nicht aktiv ist.
  ```dart
  if ((state.prevCpuChoice != null && state.prevCpuChoice != null) &&
      (state.prevScores != null && state.prevScores!.isNotEmpty) &&
      !state.isLoading)
  ```

### 3. **Spieleraktionen: Defektion oder Kooperation**

- Der User hat zwei **Buttons** zur Auswahl: „Betrügen“ (Defektion) oder „Ehrlich handeln“ (Kooperation).
- Bei jedem Knopfdruck wird ein **Event** (`PlayerMove`) ausgelöst, das die Entscheidung des Spielers überträgt:
  ```dart
  PlayerMove(decision: 'D')
  ```
  Hierbei wird die Entscheidung an den GameBloc weitergegeben, der darauf mit der Methode `_onPlayerMove` reagiert.

## 🔄 Reaktion im GameBloc (`_onPlayerMove`)

Die Methode `_onPlayerMove` im GameBloc übernimmt die Bearbeitung der Spielerentscheidung. Dieser Prozess wird im Detail wie folgt ausgeführt:

### 1. **Ladezustand setzen**

- Sobald der Spieler eine Entscheidung trifft, wird der Zustand `isLoading` auf `true` gesetzt:
  ```dart
  emit(currentState.copyWith(isLoading: true));
  ```
  Dies verhindert, dass mehrere Anfragen gleichzeitig bearbeitet werden oder unnötige UI-Updates durchgeführt werden, was zu einem Flackern der Anzeige führen könnte.

### 2. **CPU-Überlegung simulieren**

- Ein **Fake-Timer** wird erstellt, um das Nachdenken des Gegners darzustellen. Die Dauer ist zufällig und variiert zwischen 0 und 1500 Millisekunden:
  ```dart
  int timeoutMillis = Random().nextInt(1500);
  await Future.delayed(Duration(milliseconds: timeoutMillis));
  ```
  Dies erzeugt eine realistischere Interaktion und vermittelt das Gefühl, dass der Gegner ebenfalls über seine Entscheidung nachdenkt.

### 3. **Computerwahl treffen (`calculateCpuChoice`)**

- Nun wird die Wahl des CPU-Gegners getroffen, indem die Methode `calculateCpuChoice` aufgerufen wird.
- **Auswahl der Strategieparameter**: Die Strategie, die beim Speichern des Profils zufällig gewählt wurde, bestimmt, wie die CPU agiert. Die Wahrscheinlichkeiten werden wie folgt geladen:
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
  }
  ```
- **Erste Runde**: In der ersten Runde kooperiert die CPU standardmäßig:
  ```dart
  if (currentRound == 1) {
    computerChoice = "C";
  }
  ```
- **Entscheidungsalgorithmus**: Ab der zweiten Runde wird die Wahl des Gegners basierend auf dem vorherigen Zug des Spielers und der CPU getroffen. Für jeden möglichen Ausgang der vorherigen Runde wird eine unterschiedliche Wahrscheinlichkeit für Kooperation oder Defektion angewandt:

  ```dart
  else {
    double randomNumber = (random.nextDouble() * 100).floorToDouble() / 100;
    String lastHumanChoice = localHistory.last[0];
    String lastComputerChoice = localHistory.last[1];

    if (lastHumanChoice == "C" && lastComputerChoice == "C") {
      computerChoice = randomNumber < params['CC']! ? 'C' : 'D';
    } else if (lastHumanChoice == 'C' && lastComputerChoice == 'D') {
      computerChoice = randomNumber < params['CD']! ? 'C' : 'D';
    } else if (lastHumanChoice == 'D' && lastComputerChoice == 'C') {
      computerChoice = randomNumber < params['DC']! ? 'C' : 'D';
    } else if (lastHumanChoice == 'D' && lastComputerChoice == 'D') {
      computerChoice = randomNumber < params['DD']! ? 'C' : 'D';
    }
  }
  ```

  Je nach letztem Spielzug wird eine Wahrscheinlichkeitstabelle verwendet, um die Entscheidung der CPU für die nächste Runde zu bestimmen.

### 4. **Ergebnisse berechnen und Status aktualisieren**

- Nach der Wahl des CPU-Gegners werden die Ergebnisse berechnet und der State entsprechend aktualisiert. Wenn es die letzte Runde ist, wird das Spiel als beendet markiert.
- Der Ladezustand (`isLoading`) wird auf `false` gesetzt, um weitere Interaktionen zu ermöglichen und die UI zu aktualisieren.

## 🔄 Zusammenfassung

Beim Start des Spiels sieht der User das Spielerprofil und die Darstellung des Gegners, gefolgt von der Auswahl zwischen Kooperation und Defektion. Die Reaktion der CPU erfolgt auf Basis der zufällig gewählten Strategie. Die Methode `_onPlayerMove` im GameBloc steuert den Ablauf nach der Spielerentscheidung und sorgt für eine flüssige und realistische Darstellung der CPU-Antworten. 🚀
