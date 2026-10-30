# credits

A little appreciation. A beautiful ending.

Cinematic, auto-scrolling end credits for Flutter. Bring your own text, logos,
images, or any other widgets; `Credits` takes care of the scroll.

[![pub package](https://img.shields.io/pub/v/credits.svg)](https://pub.dev/packages/credits)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

<img src="https://github.com/sameteyisan/credits/blob/main/demo.gif?raw=true" alt="Credits animation demo" width="280">

## Install

```sh
flutter pub add credits
```

Requires Flutter 3.29.2+ and Dart 3.7.2+.

## Use

```dart
import 'package:credits/credits.dart';
import 'package:flutter/material.dart';

Scaffold(
  body: Credits(
    duration: const Duration(seconds: 24),
    delay: const Duration(milliseconds: 400),
    onFinished: () => debugPrint('That’s a wrap!'),
    children: const [
      Text(
        'Made together.',
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
      SizedBox(height: 32),
      FlutterLogo(size: 48),
      SizedBox(height: 32),
      Text('Thank you.', style: TextStyle(color: Colors.white)),
    ],
  ),
)
```

Press and hold to pause; release to continue. Credits also work inside a bounded
container such as a `SizedBox`. To replay, rebuild with a new `Key`.

## Customize

| Parameter | Default | Description |
| --- | --- | --- |
| `children` | Required | Widgets to include in the credits. |
| `duration` | 10 seconds | Duration of the complete scroll, excluding pauses. |
| `delay` | 300 milliseconds | Wait before starting. |
| `pauseOnTouch` | `true` | Pause while the preview is held. |
| `backgroundColor` | `Colors.black` | Background color; use transparent for a custom backdrop. |
| `curve` | `Curves.linear` | Scroll animation curve. |
| `crossAxisAlignment` | `CrossAxisAlignment.center` | Horizontal alignment of the children. |
| `onFinished` | `null` | Called once when the credits finish. |

## Try the example

The [example app](example) includes Cinema and Paper styles, duration controls,
touch-to-pause, replay, and a copyable widget snippet. It adapts to narrow and
wide screens.

The example requires Flutter 3.41+ and Dart 3.11+.

```sh
cd example
flutter pub get
flutter run
```

See [CHANGELOG.md](CHANGELOG.md) for release notes.
