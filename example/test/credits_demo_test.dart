import 'package:credits/credits.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final width in [320.0, 768.0, 1440.0]) {
    testWidgets('renders without overflow at ${width.toInt()}px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const CreditsExampleApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(Credits), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  testWidgets(
    'controls update playback, copy code, and replay after finishing',
    (tester) async {
      tester.view.physicalSize = const Size(1440, 1400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      String? clipboard;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            clipboard = (call.arguments as Map)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );

      await tester.pumpWidget(const CreditsExampleApp());
      final firstKey = tester.widget<Credits>(find.byType(Credits)).key;
      await tester.tap(find.text('Paper'));
      await tester.pump();
      expect(tester.widget<Credits>(find.byType(Credits)).key, isNot(firstKey));

      await tester.tap(find.text('16 sec'));
      await tester.pump();
      expect(
        tester.widget<Credits>(find.byType(Credits)).duration,
        const Duration(seconds: 16),
      );

      await tester.tap(find.byType(SwitchListTile));
      await tester.pump();
      expect(
        tester.widget<Credits>(find.byType(Credits)).pauseOnTouch,
        isFalse,
      );

      await tester.tap(find.byTooltip('Copy widget code'));
      await tester.pump();
      expect(clipboard, contains('Duration(seconds: 16)'));
      expect(clipboard, contains('pauseOnTouch: false'));

      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();
      expect(find.text('That’s a wrap.'), findsOneWidget);
      expect(find.byType(Credits), findsNothing);

      await tester.tap(find.text('Replay credits'));
      await tester.pump();
      expect(find.byType(Credits), findsOneWidget);
      expect(find.text('That’s a wrap.'), findsNothing);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
