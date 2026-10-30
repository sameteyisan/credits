# Credits example

A cinematic playground for the [`credits`](https://pub.dev/packages/credits)
Flutter package, with a responsive layout and Flutter-native controls.

## Run

Requires Flutter 3.41+ and Dart 3.11+. The iOS runner uses the UIScene lifecycle
and targets iOS 15+.
Android builds require JDK 17+.

```sh
flutter pub get
flutter run
```

For the browser preview, run `flutter run -d chrome`.

## Explore

- Switch between the dark **Cinema** and light **Paper** styles.
- Choose a 16-, 24-, or 36-second roll.
- Press and hold the preview to pause, or disable touch-to-pause.
- Replay at any time, including after the completion screen.
- Copy the widget snippet to try it in your own app.

Changing the style or duration starts a fresh roll. The preview demonstrates
custom text, icons, and a Flutter logo inside a bounded `Credits` widget.

DM Serif Display is bundled for consistent, offline typography. Its SIL Open
Font License is included in `assets/fonts/OFL.txt`.

## Source

- `lib/main.dart`: app entry point and Material theme.
- `lib/credits_demo.dart`: responsive page and interactive controls.
- `lib/credits_preview.dart`: credit content and completion state.
- `lib/demo_theme.dart`: shared colors and preview styles.
