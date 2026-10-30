import 'package:credits/credits.dart';
import 'package:flutter/material.dart';

import 'demo_theme.dart';

class CreditsPreview extends StatelessWidget {
  const CreditsPreview({
    super.key,
    required this.playback,
    required this.duration,
    required this.pauseOnTouch,
    required this.look,
    required this.finished,
    required this.height,
    required this.onFinished,
    required this.onReplay,
  });

  final int playback;
  final int duration;
  final bool pauseOnTouch;
  final CreditLook look;
  final bool finished;
  final double height;
  final VoidCallback onFinished;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: look.background,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: DemoColors.border),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.2),
                      radius: 0.85,
                      colors: [
                        look.accent.withValues(alpha: 0.09),
                        look.background.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(painter: _StarsPainter(look.accent)),
                ),
              ),
              if (!finished)
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(
                    context,
                  ).copyWith(scrollbars: false),
                  child: Credits(
                    key: ValueKey(playback),
                    duration: Duration(seconds: duration),
                    delay: const Duration(milliseconds: 400),
                    backgroundColor: Colors.transparent,
                    pauseOnTouch: pauseOnTouch,
                    onFinished: onFinished,
                    children: [
                      Icon(Icons.auto_awesome, color: look.accent, size: 28),
                      const SizedBox(height: 24),
                      _label('A STORY BY ALL OF US'),
                      const SizedBox(height: 18),
                      Text(
                        'Made\ntogether.',
                        textAlign: TextAlign.center,
                        style: editorialFont.copyWith(
                          fontSize: 54,
                          height: 1.05,
                          color: look.foreground,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'For the people behind the pixels.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: look.muted, fontSize: 12),
                      ),
                      _rule(),
                      _credit('DESIGN & DIRECTION', 'Alex Morgan'),
                      _credit('ENGINEERING', 'Jordan Lee\nSam Rivera'),
                      _credit('WORDS & LITTLE DETAILS', 'Taylor Quinn'),
                      _rule(),
                      _label('BUILT WITH'),
                      const SizedBox(height: 20),
                      const FlutterLogo(size: 36),
                      const SizedBox(height: 14),
                      Text(
                        'Flutter & a little imagination',
                        style: TextStyle(color: look.foreground, fontSize: 14),
                      ),
                      _rule(),
                      _label('AND, MOST IMPORTANTLY'),
                      const SizedBox(height: 16),
                      Text(
                        'You.',
                        style: editorialFont.copyWith(
                          fontSize: 56,
                          fontStyle: FontStyle.italic,
                          color: look.accent,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Thank you for being part of the story.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: look.muted, fontSize: 12),
                      ),
                      const SizedBox(height: 56),
                      Icon(
                        Icons.favorite_outline,
                        color: look.accent,
                        size: 20,
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                )
              else
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome, color: look.accent, size: 32),
                        const SizedBox(height: 24),
                        Text(
                          'That’s a wrap.',
                          textAlign: TextAlign.center,
                          style: editorialFont.copyWith(
                            color: look.foreground,
                            fontSize: 38,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Good things are made together.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: look.muted, fontSize: 13),
                        ),
                        const SizedBox(height: 24),
                        TextButton.icon(
                          onPressed: onReplay,
                          style: TextButton.styleFrom(
                            foregroundColor: look.accent,
                          ),
                          icon: const Icon(Icons.replay_rounded, size: 18),
                          label: const Text('One more time'),
                        ),
                      ],
                    ),
                  ),
                ),
              for (final top in [true, false])
                Positioned(
                  left: 0,
                  right: 0,
                  top: top ? 0 : null,
                  bottom: top ? null : 0,
                  height: 96,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: top
                              ? Alignment.topCenter
                              : Alignment.bottomCenter,
                          end: top
                              ? Alignment.bottomCenter
                              : Alignment.topCenter,
                          colors: [
                            look.background,
                            look.background,
                            look.background.withValues(alpha: 0),
                          ],
                          stops: const [0, 0.5, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 22,
                left: 22,
                right: 22,
                child: IgnorePointer(
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: look.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _label(
                          finished ? 'THAT’S A WRAP' : 'LIVE PREVIEW',
                        ),
                      ),
                      Text(
                        'END TITLES / 01',
                        style: TextStyle(
                          color: look.muted,
                          fontSize: 8,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 22,
                left: 22,
                right: 22,
                child: IgnorePointer(
                  child: Text(
                    'A LITTLE SPACE FOR THE PEOPLE WHO MADE IT POSSIBLE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: look.muted,
                      fontSize: 7,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          finished
              ? 'The end. Or the beginning of something new.'
              : pauseOnTouch
              ? 'Take your time. Press and hold the preview to pause.'
              : 'Sit back. The credits will keep rolling.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: DemoColors.muted,
            fontSize: 11,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _label(String text) => Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: look.accent,
      fontSize: 8,
      fontWeight: FontWeight.w600,
      letterSpacing: 2,
    ),
  );

  Widget _credit(String role, String names) => Padding(
    padding: const EdgeInsets.only(bottom: 32),
    child: Column(
      children: [
        _label(role),
        const SizedBox(height: 12),
        Text(
          names,
          textAlign: TextAlign.center,
          style: editorialFont.copyWith(
            color: look.foreground,
            fontSize: 26,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  Widget _rule() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 38),
    child: SizedBox(
      width: 32,
      child: Divider(color: look.accent.withValues(alpha: 0.45), height: 1),
    ),
  );
}

class _StarsPainter extends CustomPainter {
  const _StarsPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withValues(alpha: 0.2);
    for (var i = 0; i < 38; i++) {
      final x = ((i * 73 + 19) % 101) / 101 * size.width;
      final y = ((i * 37 + 11) % 97) / 97 * size.height;
      canvas.drawCircle(Offset(x, y), i % 5 == 0 ? 1 : 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(_StarsPainter oldDelegate) => oldDelegate.color != color;
}
