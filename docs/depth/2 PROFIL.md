# 📝 Eingabe von Profildaten: Überprüfung und Dialog

Im nächsten Schritt des Spiels wird geprüft, ob ein Profil für den User vorhanden ist, um eine personalisierte Spielerfahrung zu ermöglichen. Dieser Schritt sorgt dafür, dass das Spiel die individuellen Eigenschaften des Users berücksichtigt, bevor es beginnt.

## 📄 Was passiert beim Starten der GamePage?

Beim Starten des Spiels wird die **GamePage** geladen, welche die Benutzeroberfläche (UI) für das Spiel selbst darstellt. Die Logik hinter der Überprüfung und Eingabe von Profildaten wird in der **GameBloc**-Klasse implementiert und in der GamePage verwendet.

### 1. **Initialisierung im GameBloc**

- Beim Start der GamePage wird im **GameBloc** zunächst das Profil auf einen leeren Wert gesetzt. Das bedeutet, dass der Zustand `profile` standardmäßig leer oder `null` ist.
- Diese Initialisierung stellt sicher, dass das Spiel immer bei einem neutralen Ausgangspunkt beginnt, bevor geprüft wird, ob bereits ein Profil des Users vorhanden ist oder eines erstellt werden muss.

### 2. **Überprüfung des Profils beim Aufbau der GamePage**

- Während die **GamePage** gebaut wird, prüft die UI, ob ein Profil im **GameBloc State** gesetzt ist oder nicht. Diese Überprüfung ist entscheidend, um zu bestimmen, ob der User direkt ins Spiel einsteigen kann oder zuerst seine Profildaten eingeben muss.
- Wenn das Profil nicht vorhanden ist (d.h. `null` oder leer), wird der **ProfileDialog** geöffnet, damit der User seine Daten eingeben kann.

### 3. **Der ProfileDialog: Eingabe der Profildaten**

- Der **ProfileDialog** ist eine eigene Komponente, die speziell dafür entwickelt wurde, die Eingabe der Profildaten zu ermöglichen. Der Dialog wird direkt auf der GamePage angezeigt und ist ein modales Fenster, das den User daran hindert, fortzufahren, bevor er seine Profildaten eingibt.
- **Beispielhafter Ablauf im Code**:
  - Wenn festgestellt wird, dass das Profil leer ist, wird der ProfileDialog wie folgt geöffnet:
  ```dart
  showDialog(
    context: context,
    builder: (context) => ProfileDialog(),
  );
  ```
  - Der Dialog enthält Eingabefelder, in denen der User Informationen wie Name und Alter angeben kann, die dann zur Personalisierung des Spiels verwendet werden.

### 4. **Speichern der Profildaten mittels eines Events**

- Nachdem der User seine Profildaten eingegeben hat und diese bestätigt, wird ein entsprechendes **Event** ausgelöst, um diese Daten im **State** zu speichern.
- Der **GameBloc** empfängt dieses Event, validiert die Eingaben (falls nötig), und speichert das Profil im State ab. Dies ermöglicht dem Spiel, die eingegebenen Profildaten in späteren Spielphasen zu verwenden.
- **Beispiel für ein Event zur Speicherung**:
  ```dart
  BlocProvider.of<GameBloc>(context).add(ProfileSubmittedEvent(profileData));
  ```
  - Das Event `ProfileSubmittedEvent` übergibt die eingegebenen Profildaten an den GameBloc, welcher daraufhin den State aktualisiert und sicherstellt, dass das Profil für den weiteren Spielverlauf bereitsteht.

### 5. **Speichern des Profils im GameBloc (`_onSaveProfile`) und Auswahl der Strategie**

- Das Event `ProfileSubmittedEvent` löst im **GameBloc** die Methode `_onSaveProfile` aus. Diese Methode führt die folgenden Schritte aus:
  - **Zufällige Strategieauswahl**: Beim Speichern des Profils wird auch eine zufällige Strategie ausgewählt, mit der die CPU spielt. Dies geschieht, indem eine der verfügbaren Strategien zufällig bestimmt wird:
    ```dart
    final selectedStrategy = strategies[Random().nextInt(strategies.length)];
    ```
    Diese Strategie bleibt für die gesamte Spieldauer unverändert und wird für die CPU verwendet.
  - **Validierung der Profildaten**: Zuerst werden die Profildaten, die vom User eingegeben wurden, auf ihre Gültigkeit überprüft. Falls bestimmte Bedingungen nicht erfüllt sind, wird der Vorgang möglicherweise abgebrochen oder der User muss die Eingaben korrigieren.
  - **Aktualisierung des States**: Wenn die Profildaten gültig sind, wird der State des GameBloc aktualisiert, sodass das Profil nun im State enthalten ist. Dies geschieht, indem der neue State mit den aktualisierten Profildaten erstellt wird.
  - **Benachrichtigung der UI**: Nachdem der State aktualisiert wurde, werden alle Abonnenten (d.h. die UI-Komponenten, die den GameBloc überwachen) benachrichtigt, sodass die UI entsprechend reagieren und aktualisiert werden kann. Dadurch wird sichergestellt, dass das Spiel den neuen Profilstatus korrekt anzeigt und verwendet.

## 🔄 Zusammenfassung

Beim Start des Spiels wird geprüft, ob der User bereits ein Profil angelegt hat. Falls dies nicht der Fall ist, wird der **ProfileDialog** geöffnet, um den User zur Eingabe der notwendigen Informationen aufzufordern. Diese Profildaten werden dann im **GameBloc** gespeichert, um eine individuelle Spielerfahrung zu ermöglichen. Der Einsatz des BLoC Patterns sorgt hier dafür, dass die Logik zur Überprüfung und Speicherung der Profildaten sauber von der UI getrennt ist. 🚀
