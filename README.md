# SharedPrefs

In diesem Projekt wird demonstriert, wie man SharedPreferences (oder auch viele andere Datenbanken) und Provider zusammen nutzen kann.

## Quellen

[Shared Preferences-Package](https://pub.dev/packages/shared_preferences)  
[Provider](https://pub.dev/packages/provider)  
[Vorlesung Shared Prefs](https://docs.google.com/presentation/d/1eM7_HxhhcV4Tz_G0ywbGXBqy3Spnyd-IC17IMMld_1c/edit?usp=sharing)  
[Vorlesung Provider](https://docs.google.com/presentation/d/1hjn2wam0CanvSy2QpbIiwFLuEUXxOS5WAEsKSEelsKA/edit?slide=id.g36327d5c0f3_0_1#slide=id.g36327d5c0f3_0_1)

---

### 1. Step: Packages hinzufügen

Im Terminal:

```
flutter pub get shared_preferences
flutter pub get provider
```

Oder alternativ über die VSCode Benutzeroberfläche und überprüft, ob die Dependencies in [pubspec.yaml](pubspec.yaml) eingetragen worden sind.

---

### 2. Repository oder Service bauen

Ihr erstellt eine Klasse für die Daten, die ihr repräsentieren wollt. In unserem Beispiel möchten wir in unseren Speicher jeweils unseren aktuellen `ThemeMode` und den aktuellen Wert unseres `Counters` speichern.

```dart
class CounterRepository {
  int _counter = 0;

  CounterRepository() {
    ...
  }

  int get counter => _counter; // getter für unseren aktuellen Counter

  ...
}
```

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeProvider() {
    ...
  }

  bool get isDarkMode => _isDarkMode; // getter-Methode für unser bool
}
```

---

### 3. SharedPreferences verwenden

Wir möchten SharedPreferences benutzen, um kleine Daten wie User-Einstellungen zu speichern.

Dazu können folgende Szenarien gehören:

- PIN-Versuche
- präferierter Theme-Mode
- Highscore
- API-Endpunkte
- Onboarding eines Nutzers durchgeführt oder nicht

SharedPreferences werden in Schlüssel-Wert-Paaren gespeichert und können nur primitive Datentypen speichern wie:

- bool
- int
- double
- String
- Liste aus Strings

Außerdem geben SharedPrefs nur `Future`-Werte zurück.

Wir setzen unseren Schlüssel wie folgt in unserer Counter-Repo-Klasse:

```dart
class CounterRepository {
  static const String _counterKey = "current_counter";
  int _counter = 0; // Initialwert
}
```

Um unsere Werte auslesen zu können brauchen wir einen Loader und rufen diesen im Konstruktor unserer Klasse auf:

```dart
CounterRepository() {
    _loadCounter();
  }

Future<void> _loadCounter() async {
    final _prefs = await SharedPreferences.getInstance();
    _counter = _prefs.getInt(_counterKey) ?? 0;

  }
```

Um neue Werte zu setzen, schreiben wir folgende Methode:

```dart
Future<void> setCurrentCounter(int counter) async {
  final _prefs = await SharedPreferences.getInstance();
  await _prefs.setInt(_counterKey, counter);
  _counter = counter;

}
```

Um unseren Counter zurückzusetzen, brauchen wir folgende Methode:

```dart
void deleteCounter() async {
  final _prefs = await SharedPreferences.getInstance();
  await _prefs.remove(_counterKey);
  _counter = 0;
}
```

---

### 4. ChangeNotifier in Service-Klasse hinzufügen

Damit eure Service-Klasse (z.B. CounterRepository, ThemeProvider) Änderungen an die UI weitergeben kann, erweitert sie `ChangeNotifier` und ruft nach Änderungen `notifyListeners()` auf.

```dart

class CounterRepository with ChangeNotifier { // hier ist die Änderung zu Change Notifier
    Future<void> setCurrentCounter(int counter) async {
    ...
    ...
    notifyListeners(); // in Setter aufrufen
    }

    Future<void> _loadCounter() async {
    ...
    ...
    notifyListeners();

  }
}
```

---

### 5. Multiprovider in main.dart

In der `main.dart` wird euer App-Widget mit einem `MultiProvider` umschlossen, damit die Provider überall im Widget-Tree verfügbar sind.

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterRepository()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}
```

---

### 6. .watch & .read verwenden

Um auf die Werte und Methoden eurer Provider zuzugreifen, verwendet ihr in euren Widgets:

```dart
final counterRepo = context.watch<CounterRepository>();
final themeProvider = context.read<ThemeProvider>();
```

- Mit `.watch` wird das Widget neu gebaut, wenn sich der Wert ändert.
- Mit `.read` wird der Wert nur einmal gelesen (z.B. für Methodenaufrufe) normalerweise in Callbackfunktionen

---

### 7. Beispiel: Werte anzeigen und ändern

```dart
Switch(
  value: themeProvider.isDarkMode,
  onChanged: (bool value) {
    context.read<ThemeProvider>().setCurrentThemeMode(value);
  },
)

FloatingActionButton(
  onPressed: () {
    context.read<CounterRepository>().setCurrentCounter(counterRepo.counter + 1);
  },
  child: Icon(Icons.add),
)
```

---

## Fazit

Mit SharedPreferences und Provider könnt ihr einfach kleine Daten persistent speichern und im gesamten Widget-Tree auf sie zugreifen. Für komplexere Daten empfiehlt sich eine Datenbank wie SQLite oder Hive.
