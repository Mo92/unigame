# 🏆 Anzeige der Spielergebnisse

Nachdem der Fragebogen vom User ausgefüllt wurde, zeigt die **GamePage** die Ergebnisse des Spiels an. Dies dient dazu, dem User eine Zusammenfassung seines Spiels zu bieten und sowohl seinen eigenen Erfolg als auch den des Gegners zu bewerten.

## 📄 Ablauf zur Ergebnisanzeige

In der **GamePage** wird überprüft, ob das Spiel beendet wurde und ob der Fragebogen bereits ausgefüllt ist. Nur dann werden die Ergebnisse angezeigt:

```dart
if (state.hasGameEnded && state.postQuestions != null) {
  // Zeige die Ergebnisse an
}
```

### 1. **Anzeigen des Resultats: Sieg, Niederlage oder Unentschieden**

Je nach Punktestand des Users und der CPU wird ein unterschiedlicher Text angezeigt, der das Spielresultat zusammenfasst:

- **Sieg des Users**: Wenn der User mehr Punkte als die CPU gesammelt hat, wird eine entsprechende Erfolgsmeldung angezeigt:
  ```dart
  if (state.playerScore > state.cpuScore) {
    // Text für den Sieg des Users
  }
  ```
- **Niederlage des Users**: Wenn die CPU mehr Punkte als der User erzielt hat, wird eine Nachricht angezeigt, die die Niederlage des Users darstellt:
  ```dart
  if (state.playerScore < state.cpuScore) {
    // Text für die Niederlage des Users
  }
  ```
- **Unentschieden**: Falls der User und die CPU gleich viele Punkte erzielt haben, wird ein neutraler Text für das Unentschieden angezeigt:
  ```dart
  if (state.playerScore == state.cpuScore) {
    // Text für das Unentschieden
  }
  ```

Diese Logik sorgt dafür, dass der User eine klare Rückmeldung über den Ausgang des Spiels erhält und weiß, ob er gewonnen, verloren oder ein Unentschieden erreicht hat.

### 2. **Ergebnishistorie jeder Runde (`_buildScores`)**

Die Methode `_buildScores` wird verwendet, um die Historie des gesamten Spiels für jede Runde zusammenzustellen und aufzulisten. Für jede Runde werden die folgenden Informationen angezeigt:

- **Rundenzähler**: Die aktuelle Rundennummer wird hochgezählt und angezeigt.
- **Entscheidungen**: Die Wahl des Users (Kooperation oder Defektion) und die Entscheidung der CPU werden aufgeführt. Dazu wird die Methode `defectOrCoop(choice)` verwendet, die die Entscheidung in eine verständliche Bezeichnung wie „Kooperation“ oder „Defektion“ übersetzt.
- **Punkte**: Die Punkte, die der User und die CPU in der jeweiligen Runde erzielt haben, werden dargestellt.

Der Ablauf der Schleife sieht dabei wie folgt aus:

```dart
for (final round in state.history) {
  roundCount = roundCount + 1;
  final hChoice = round[0];
  final cChoice = round[1];
  final scores = round[2];

  rows.add(
    Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 12),
          Text('Runde ${roundCount + 1}:'),
          SizedBox(width: 4),
          Text(
              'Du = ${defectOrCoop(hChoice)}, Dealer =  ${defectOrCoop(cChoice)}'),
          SizedBox(width: 4),
          Text('Punkte: Du = ${scores[0]}, Dealer= ${scores[1]}'),
          SizedBox(width: 12),
        ],
      ),
    ),
  );
}
```

### 3. **Auflistung der Ergebnisse**

- Für jede Runde wird eine **Reihe von Ergebnissen** erzeugt und der Liste der angezeigten `rows` hinzugefügt.
- Diese Liste wird anschließend zurückgegeben und der ausrufenden Methode übermittelt, damit die gesamte Ergebnishistorie der einzelnen Runden dargestellt wird.

Dies sorgt dafür, dass der User nicht nur den Gesamtstand sieht, sondern auch eine detaillierte Auflistung jeder Runde nachvollziehen kann, einschließlich der getroffenen Entscheidungen und der Punkteverteilung.

## 🗃️ Datenexport im Hintergrund

Nachdem das Spiel offiziell beendet ist und die Ergebnisse angezeigt wurden, erfolgt im Hintergrund ein **Datenexport**. Dieser Schritt dient der Speicherung aller relevanten Daten in der Cloud, um sicherzustellen, dass die Ergebnisse und Spielentscheidungen für Analysezwecke oder zukünftige Spiele bereitstehen.

---

Die Anzeige der Spielergebnisse ist ein wichtiger Bestandteil, um dem User ein Feedback über seine Spielleistung zu geben. Die dynamische Ergebnisanzeige sowie die detaillierte Rundenauswertung ermöglichen es, den Spielverlauf komplett nachzuvollziehen und zu verstehen, wie sich der User und die CPU in den verschiedenen Runden verhalten haben. 🚀
