import 'package:calcular_nota_sjb/pages/home_page.dart';
import 'package:calcular_nota_sjb/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeChanger(ThemeChanger.lightTheme),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, themeChanger, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Calcular Nota',
          theme: themeChanger.themeData,
          home: const HomePage(),
        );
      },
    );
  }
}
