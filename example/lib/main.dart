import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'credits_demo.dart';
import 'demo_theme.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['DM Serif Display'], license);
  });
  runApp(const CreditsExampleApp());
}

class CreditsExampleApp extends StatelessWidget {
  const CreditsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credits — a beautiful ending',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: DemoColors.background,
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: DemoColors.gold,
              brightness: Brightness.dark,
              surface: DemoColors.surface,
            ).copyWith(
              primary: DemoColors.gold,
              onPrimary: DemoColors.background,
              onSurface: DemoColors.text,
            ),
        dividerColor: DemoColors.border,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      home: const CreditsDemo(),
    );
  }
}
