# SharedPrefs

In diesem Projekt wird demonstriert, wie man SharedPreferences (oder auch viele andere Datenbanken) und Provider zusammen nutzen kann.

## Quellen

[Shared Preferences-Package](https://pub.dev/packages/shared_preferences)
[Provider](https://pub.dev/packages/provider)
[Vorlesung Shared Prefs](https://docs.google.com/presentation/d/1eM7_HxhhcV4Tz_G0ywbGXBqy3Spnyd-IC17IMMld_1c/edit?usp=sharing)
[Vorlesung Provider](https://docs.google.com/presentation/d/1hjn2wam0CanvSy2QpbIiwFLuEUXxOS5WAEsKSEelsKA/edit?slide=id.g36327d5c0f3_0_1#slide=id.g36327d5c0f3_0_1)

### 1. Step: Packages hinzufügen

Im Terminal

```
flutter pub get shared_preferences
flutter pub get provider
```

oder alternativ über die VSCode Benutzeroberfläche und überprüft ob die Dependencies in [pubspec.yaml](pubspec.yaml) eingetragen worden sind

### 3. Repository oder Service bauen

Ihr erstellt eine Klasse für die Daten die ihr repräsentieren wollt. In unserem Beispiel möchten wir in unseren Speicher jeweils unseren aktuellen `ThemeMode` und den aktuellen Wert unseres `Counters` speichern.

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

### 4. SharedPreferences verwenden

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

außerdem geben SharedPrefs nur `Future`-Werte zurück.

Wir setzen unseren Schlüssel wie folgt in unserer Counter-Repo-Klasse:

```dart
class CounterRepository {

 static const String _counterKey = "current_counter";

 int _counter = 0; // Initialwert

}
```

### 5. ChangeNotifier in Service-Klasse hinzufügen

### 6. Multiprovider in main.dart

### 7. .watch & read verwenden
