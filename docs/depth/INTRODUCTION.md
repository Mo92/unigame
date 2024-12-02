# 🎮 Überblick: Funktion des Spiels

Dieses Dokument gibt einen groben Überblick über die Funktionsweise des Spiels. Das Programm ist so gestaltet, dass es einem User ermöglicht, an einem spannenden und interaktiven Spiel teilzunehmen. Im Folgenden beschreiben wir die wesentlichen Bestandteile und Abläufe des Programms.

## 🚀 Die Hauptbestandteile des Programms

Das Spiel lässt sich in sechs Hauptbestandteile unterteilen:

1. **Einleitung**: Das Programm startet mit einer Einführung, die den User willkommen heißt und die Spielmechanik erklärt. In diesem Abschnitt erhält der User einen Überblick über die Spielregeln, die Ziele und den Ablauf des Spiels.

2. **Eingabe von Profildaten**: Der User gibt seine Profildaten ein, die für das Spiel benötigt werden. Diese Daten sind wichtig, um eine personalisierte Spielerfahrung zu ermöglichen und um später statistische Auswertungen zu machen.

3. **Das Spiel an sich**: Das Herzstück des Programms ist das Spiel selbst. Es besteht aus mehreren Runden, in denen der User strategische Entscheidungen treffen muss. Jede Runde beeinflusst das Ergebnis und stellt den User vor neue Herausforderungen, bei denen es um Kooperation, Täuschung und Gewinnmaximierung geht.

4. **Fragebogen nach der letzten Runde**: Nach Abschluss der letzten Runde füllt der User einen Fragebogen aus. Dieser Fragebogen hilft dabei, Feedback zu sammeln und das Verhalten des Users während des Spiels zu analysieren. Die Fragen betreffen typischerweise die Entscheidungsfindung und die Erfahrungen des Users während des Spiels.

5. **Anzeige der Ergebnisse**: Nach dem Spiel werden die Ergebnisse für jede Runde und das Gesamtergebnis angezeigt. Dies gibt dem User die Möglichkeit, seine Leistung zu bewerten und zu sehen, wie er im Vergleich zu den möglichen Ergebnissen abgeschnitten hat. Die Anzeige der Ergebnisse ist interaktiv und bietet visuelle Darstellungen der gesammelten Daten.

6. **Datenexport**: Während die Ergebnisse angezeigt werden, erfolgt ein Export der Daten in die Cloud. Dies stellt sicher, dass alle relevanten Informationen des Spiels gespeichert werden. Die Daten können zu Analysezwecken verwendet werden und helfen dabei, das Spiel und das Verhalten der User zu optimieren.

## ⚙️ Verwendung des BLoC Patterns in Flutter (Web)

Das Spiel wurde in **Flutter (Web)** entwickelt und nutzt zur Implementierung der Logik das **BLoC Pattern**. Dieses Pattern ist besonders hilfreich, um die Geschäftslogik vom UI-Code zu trennen und sicherzustellen, dass das Programm sauber strukturiert und leicht zu warten ist.

### Was ist das BLoC Pattern?

BLoC steht für **Business Logic Component** und ist ein Architekturpattern, das die Zustandsverwaltung innerhalb einer Flutter-Anwendung ermöglicht. Mit BLoC wird die App in drei Hauptteile unterteilt: **State**, **Event**, und **BLoC**:

1. **Event**: Ein **Event** ist eine Aktion, die vom User ausgelöst wird. Im Spiel könnten das beispielsweise Entscheidungen des Users während einer Runde oder das Ausfüllen des Fragebogens sein. Jedes Event beschreibt eine Absicht, die das Programm umsetzen soll.

2. **State**: Der **State** beschreibt den Zustand der Anwendung zu einem bestimmten Zeitpunkt. Während der User spielt, wird der aktuelle Zustand des Spiels im State gespeichert. Dieser Zustand ändert sich in Abhängigkeit von den Events, die durch den User oder das Spiel selbst ausgelöst werden.

3. **BLoC**: Die **BLoC-Komponente** verbindet die **Events** mit den **States**. Wenn ein Event ausgelöst wird, verarbeitet der BLoC dieses Event und aktualisiert entsprechend den State. Der BLoC ist somit das Herzstück der Geschäftslogik und kümmert sich um alle Veränderungen des Zustands basierend auf den Aktionen des Users.

![BLoC Pattern Übersicht](https://github.com/felangel/bloc/blob/master/assets/diagrams/bloc_architecture.png?raw=true)

### Wie wird das BLoC Pattern im Spiel genutzt?

- **State Management**: Das Spiel hat verschiedene Zustände, wie z.B. die Eingabe von Profildaten, das Spielen einer Runde, oder das Anzeigen der Ergebnisse. All diese Zustände werden mit Hilfe des BLoC Patterns verwaltet, sodass immer genau der Zustand der Anwendung angezeigt wird, der dem aktuellen Ablauf entspricht.

- **Events im Spiel**: Verschiedene Aktionen des Users, wie das Starten des Spiels, das Treffen einer Entscheidung in einer Runde, oder das Ausfüllen des Fragebogens, werden als Events an den BLoC gesendet. Diese Events lösen dann Veränderungen des Zustands aus, die wiederum das UI anpassen.

- **State Updates**: Wenn der User eine Entscheidung trifft, berechnet der BLoC basierend auf der Geschäftslogik den neuen State. Dieser neue State wird an das UI gesendet, um die Darstellung zu aktualisieren. Dies sorgt dafür, dass die App immer reaktiv auf die Eingaben des Users reagiert und den aktuellen Stand des Spiels widerspiegelt.

### Beispiel

Ein einfaches Beispiel wäre der Wechsel vom **Eingabemodus** für Profildaten zum eigentlichen **Spielmodus**:

- Wenn der User seine Daten eingibt und bestätigt, wird ein **ProfileSubmitEvent** ausgelöst.
- Der BLoC empfängt dieses Event, validiert die Daten und wechselt den Zustand in den **GameStartedState**.
- Das UI wird informiert und zeigt nun den Spielbildschirm an, in dem der User die erste Runde starten kann.

---

Mit dem BLoC Pattern wird eine klare Trennung zwischen Logik und UI erreicht, was die Wartbarkeit des Codes deutlich verbessert. Im nächsten Schritt werden wir die spezifischen Mechanismen genauer betrachten, die für das Spiel wichtig sind. 🚀
