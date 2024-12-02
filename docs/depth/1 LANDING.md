# ✨ Einleitung: Landing Page des Spiels

Das Spiel startet immer mit der **Landing Page**, die in der Datei `landing_page.dart` definiert ist und sich unter `lib/pages/` befindet. Diese Seite dient als Einstiegspunkt für das Spiel und heißt den User willkommen, während sie die Grundlagen der Spielmechanik vermittelt.

## 📄 Was passiert auf der Landing Page?

Die Landing Page ist eine statische Seite, die die grundlegende Struktur und Einführung des Spiels enthält. Im folgenden Abschnitt wird beschrieben, wie die einzelnen Komponenten der Landing Page aufgebaut sind und welche Funktionen sie erfüllen:

### 1. **Allgemeiner Aufbau**

Die `LandingPage` ist eine **StatelessWidget**-Klasse, was bedeutet, dass sie keinen Zustand hat, der während ihrer Lebensdauer geändert wird. Sie wird verwendet, um die Startansicht des Spiels darzustellen und hat eine einfache, aber interaktive Benutzeroberfläche, die den User durch den ersten Teil des Spiels führt.

### 2. **Der Hauptinhalt (`_buildBody`)**

Die Methode `_buildBody(BuildContext context)` definiert den Hauptinhalt der Seite. Folgende Elemente sind enthalten:

- **SingleChildScrollView**: Diese Komponente sorgt dafür, dass der gesamte Inhalt scrollbar ist, was besonders auf kleineren Bildschirmen hilfreich ist, damit der User alle Elemente sehen kann.
- **Padding und Column**: Der Inhalt wird in einen **Padding**-Wrapper gepackt, um den Text und andere Elemente auf der Seite einzurücken, und dann in einer **Column** organisiert, um die verschiedenen Textabschnitte und Buttons vertikal anzuordnen.

### 3. **Texte und Einführung**

- Die **Einführungstexte** begrüßen den User und erklären das Spiel. Der erste Text ist groß und fett gedruckt, um als Titel zu dienen:

  ```dart
  Text(
    'Das Spiel ums große Geld',
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  )
  ```

  Dies vermittelt dem User direkt den Namen und das Ziel des Spiels.

- Anschließend folgt eine Beschreibung der Spielmechanik und der Grundidee des Spiels, um den User auf das vorzubereiten, was folgen wird. Diese Texte sind im mittleren Schriftgrad gehalten, um angenehm lesbar zu sein.

### 4. **Abschnittsüberschriften und Bullet Points**

- Die Einführung enthält **Abschnittsüberschriften**, wie „Deine Mission“ und „Das Geschäft“, um verschiedene Teile der Spielmechanik hervorzuheben und die Struktur klar zu machen.
- Die **Bullet Points** werden durch das benutzerdefinierte Widget `BulletPoint` dargestellt, das in einer anderen Datei definiert ist. Diese Bullet Points sind dazu da, dem User wichtige Entscheidungen im Spiel klar und verständlich zu präsentieren, wie z.B. „Ehrlich handeln“ oder „Betrügen“.

### 5. **Interaktivität und Navigation**

- Am Ende der Seite findet sich ein **ElevatedButton**, mit dem der User das eigentliche Spiel starten kann:
  ```dart
  ElevatedButton(
    onPressed: () => Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => GameBloc(),
          child: GamePage(),
        ),
      ),
    ),
    child: const Text('Spiel starten'),
  )
  ```
  - **Navigation**: Wenn der Button gedrückt wird, wird der User zur **GamePage** weitergeleitet, und der aktuelle Navigator-Stack wird ersetzt (`pushReplacement`). Das bedeutet, dass der User nach dem Start des Spiels nicht mehr zur Landing Page zurückkehren kann, indem er die Zurück-Taste benutzt.
  - **BlocProvider**: Hier wird der **GameBloc** bereitgestellt, der die Spielzustände und -ereignisse verwaltet. Das BLoC Pattern sorgt dafür, dass die Logik des Spiels sauber vom User Interface getrennt ist.

### 6. **AppBar und Seitenstruktur**

Die Landing Page besitzt eine **AppBar**, die den Titel „Shadow Deals“ anzeigt. Die Farbe der AppBar wird durch das aktuelle Farbschema bestimmt, was eine einheitliche User Experience gewährleistet:

```dart
appBar: AppBar(
  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  title: const Text('Shadow Deals'),
)
```

Diese AppBar sorgt dafür, dass der User immer sieht, in welcher App er sich befindet, und gibt der Seite einen professionellen Look.

## 🔄 Zusammenfassung

Die Landing Page ist der erste Kontaktpunkt zwischen dem User und dem Spiel. Sie begrüßt den User, gibt ihm einen Überblick über die Spielregeln und Spielmechaniken und bietet einen Button, um das Spiel zu starten. Die Seite ist einfach gehalten, jedoch interaktiv genug, um den User zur Teilnahme zu motivieren. Mit der Nutzung des BLoC Patterns und klarer Navigation wird sichergestellt, dass der Übergang ins eigentliche Spiel nahtlos verläuft.

Im nächsten Schritt geht es dann weiter zur Eingabe von Profildaten, um die Spielerfahrung zu personalisieren. 🚀
