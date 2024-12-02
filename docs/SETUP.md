# 📘 UniGame Setup Guide

In dieser Anleitung erfährst du, wie du das Repository [UniGame](https://github.com/Mo92/unigame) klonen und starten kannst. Außerdem erhältst du einen Überblick über alle benötigten Abhängigkeiten und Installationsschritte.

## 🚀 Voraussetzungen

Bevor du loslegen kannst, stelle sicher, dass du die folgenden Dinge installiert hast:

1. **Git**: Zum Klonen des Repositories. Installiere Git über [diese Anleitung](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).
2. **Flutter SDK**: Du benötigst Flutter SDK Version 3.5.4 oder höher. Folge [dieser Anleitung](https://docs.flutter.dev/get-started/install), um Flutter zu installieren.

> **Hinweis**: Stelle sicher, dass du `Flutter` Version 3.5.4 oder höher verwendest, damit alle Funktionen kompatibel sind.

## 📂 Repository klonen

Um das Repository zu klonen, öffne dein Terminal und führe den folgenden Befehl aus:

```bash
# Klone das UniGame Repository
git clone https://github.com/Mo92/unigame.git

# Wechsel in das geklonte Verzeichnis
cd unigame
```

## 📦 Zusätzliche Konfiguration

Bevor du das Projekt startest, musst du eine Datei im Verzeichnis `assets/` erstellen:

1. **credentials.json**: Erstelle die Datei `credentials.json` unter `assets/`. Diese Datei wird für den Export von CSV-Dateien benötigt.

   - Du kannst eine leere JSON-Datei erstellen, indem du den folgenden Befehl ausführst:
     ```bash
     echo '{}' > assets/credentials.json
     ```
   - Ohne diese Datei startet das Programm nicht. Auf Anfrage kannst du vom Owner eine valide Datei erhalten. Ohne die valide Datei kann das Programm zwar gestartet werden, jedoch wird der CSV-Export fehlschlagen.

## 🏃‍♂️ Flutter Projekt starten

Um das Flutter-Projekt zu starten, führe den folgenden Befehl aus:

```bash
# Starte die Flutter-Anwendung
flutter run
```

Dieser Befehl startet die Anwendung auf einem verbundenen Gerät oder Emulator. Stelle sicher, dass ein Emulator läuft oder ein Gerät verbunden ist.

## 🔗 Nützliche Links

- [Git installieren](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Flutter SDK installieren](https://docs.flutter.dev/get-started/install)
- [UniGame Repository](https://github.com/Mo92/unigame)

Wenn du weitere Fragen hast oder auf Probleme stößt, schaue dir die README-Datei des Projekts auf GitHub an oder öffne ein Issue im Repository. Viel Spaß beim Entwickeln! 🚀
