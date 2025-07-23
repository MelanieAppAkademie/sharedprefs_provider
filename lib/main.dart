import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedprefs_provider/counter_repo.dart';
import 'package:sharedprefs_provider/my_home_page.dart';
import 'package:sharedprefs_provider/theme.dart';
import 'package:sharedprefs_provider/theme_provider.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final materialTheme = MaterialTheme(ThemeData().textTheme);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(title: "Flutter Demo"),
    );
  }
}
