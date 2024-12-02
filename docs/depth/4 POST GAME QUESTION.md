# 📝 Fragebogen nach der letzten Runde

Nachdem der User alle Spielrunden beendet hat, wird ein Fragebogen angezeigt, um Feedback zu sammeln und weitere Informationen über die Spielentscheidung zu erhalten. Hier wird beschrieben, wie dieser Fragebogen dargestellt wird und welche Schritte dabei ablaufen.

## 🔄 Ablauf nach der letzten Runde

Wenn im **GameBloc** während des **PlayerMove**-Events festgestellt wird, dass es sich um die letzte Runde handelt, wird dies im **State** mitgeteilt:

```dart
hasGameEnded: currentRound >= maxRounds,
```

### 1. **Überprüfung auf der GamePage**

In der **GamePage** wird überprüft, ob das Spiel beendet ist und ob der Fragebogen bereits ausgefüllt wurde. Falls das Spiel beendet ist und der Fragebogen noch nicht vorhanden ist, wird der **PostGameDialog** angezeigt:

```dart
if (state.hasGameEnded && state.postQuestions == null) {
  return PostGameDialog(gameBloc: BlocProvider.of<GameBloc>(context));
}
```

Der **PostGameDialog** dient als Eingabeformular für den User, um einige Fragen nach Abschluss des Spiels zu beantworten.

## 📄 PostGameDialog: Der Fragebogen

Der **PostGameDialog** zeigt verschiedene Fragen an, um Feedback vom User zu erhalten. Diese Fragen beinhalten sowohl einfache **Ja/Nein-Fragen** als auch detailliertere Fragen, bei denen der User weitere Informationen angeben muss, basierend auf der gewählten Antwort.

### 2. **Widgets für die Fragen**

Um den Fragebogen dynamisch und wiederverwendbar zu gestalten, werden spezielle Widgets verwendet, darunter:

- **ConditionalInputs Widget**: Dieses Widget wird verwendet, wenn bestimmte Antworten eine zusätzliche Erklärung benötigen. Zum Beispiel bei Ja/Nein-Fragen, bei denen der User weitere Details angeben soll, wenn er „Ja“ ausgewählt hat. Das Widget zeigt abhängig von der Antwort ein weiteres Eingabefeld an, das vom User ausgefüllt werden muss.

- **UnderstandingRadios Widget**: Dieses Widget stellt die **Radio Buttons** zur Verfügung, die dem User die Möglichkeit geben, eine von mehreren Optionen auszuwählen. Die **Radio Buttons** sind hilfreich, um schnell und einfach Entscheidungen wie „Ja“ oder „Nein“ zu treffen. Das Widget ist so konzipiert, dass es flexibel eingesetzt werden kann und unterschiedliche Optionen für verschiedene Fragen darstellt.

### 3. **Dynamische Texte und Übersetzungen**

Je nach Nutzung des **ConditionalInputs** und **UnderstandingRadios** Widgets wird unterschiedlicher Text angezeigt, damit die Widgets mehrfach verwendet werden können. Die Übersetzungen und die Texte werden über ein **Mapping** (siehe [Mapping](https://en.wikipedia.org/wiki/Hash_table)) in der Datei `lib/core/helpers.dart` bereitgestellt. Dieses Mapping ermöglicht es, die entsprechenden Texte dynamisch auszugeben, ohne dass der Code für jedes Widget angepasst werden muss.

### 4. **Speichern der Antworten**

Nachdem der User alle Fragen beantwortet hat, wird die Eingabe validiert und das Event **SavePostQuestions** ausgelöst. Dies teilt dem **GameBloc** mit, dass die Fragen gespeichert werden sollen.

- Im **GameBloc** wird dieses Event verarbeitet, indem der Fragebogen im **State** gespeichert wird. Dadurch wird sichergestellt, dass die Antworten vorliegen und dass die UI informiert wird, dass der Fragebogen nun vorhanden ist. Somit ist die Bedingung am Anfang (`state.postQuestions == null`) nicht mehr erfüllt, und der Fragebogen muss nicht erneut angezeigt werden.

## 🔄 Weiter zum nächsten Schritt

Nachdem der Fragebogen gespeichert wurde, zeigt die UI den nächsten Schritt an: die **Anzeige der Ergebnisse**. Der User bekommt eine Übersicht über seine Leistung in den verschiedenen Spielrunden und kann seine Entscheidungen sowie die Entscheidungen des Gegners nachvollziehen.

---

Dieser Fragebogen ist ein wichtiger Bestandteil des Spiels, da er zusätzliche Einblicke in das Verhalten des Users liefert und dabei hilft, das Spiel weiter zu verbessern. Die dynamischen Widgets und die Verwendung von Mappings machen den Fragebogen flexibel und wiederverwendbar. 🚀
