import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'credits_preview.dart';
import 'demo_theme.dart';

class CreditsDemo extends StatefulWidget {
  const CreditsDemo({super.key});

  @override
  State<CreditsDemo> createState() => _CreditsDemoState();
}

class _CreditsDemoState extends State<CreditsDemo> {
  int _duration = 24;
  int _playback = 0;
  bool _pauseOnTouch = true;
  bool _finished = false;
  CreditLook _look = CreditLook.cinema;

  void _replay() {
    setState(() {
      _playback++;
      _finished = false;
    });
  }

  String get _snippet =>
      '''Credits(
  duration: const Duration(seconds: $_duration),
  pauseOnTouch: $_pauseOnTouch,
  children: const [
    Text('Made together.'),
    FlutterLogo(size: 32),
  ],
)''';

  Future<void> _copySnippet() async {
    await Clipboard.setData(ClipboardData(text: _snippet));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Widget copied to clipboard.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            final compact = constraints.maxWidth < 600;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 20 : 40,
                vertical: compact ? 24 : 36,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(compact),
                      SizedBox(height: compact ? 40 : 64),
                      const _Eyebrow('A LITTLE APPRECIATION GOES A LONG WAY'),
                      const SizedBox(height: 18),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Every story deserves\n'),
                            TextSpan(
                              text: 'a beautiful ending.',
                              style: const TextStyle(
                                color: DemoColors.gold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        style: editorialFont.copyWith(
                          fontSize: compact ? 38 : 64,
                          height: 1.12,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Turn a list of names into a moment worth staying for.\n'
                        'End credits for your Flutter app, made simple.',
                        style: TextStyle(
                          color: DemoColors.muted,
                          fontSize: 15,
                          height: 1.7,
                        ),
                      ),
                      SizedBox(height: compact ? 32 : 40),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 7, child: _preview(720)),
                            const SizedBox(width: 28),
                            Expanded(flex: 5, child: _settings()),
                          ],
                        )
                      else ...[
                        _preview(compact ? 420 : 536),
                        const SizedBox(height: 24),
                        _settings(),
                      ],
                      const SizedBox(height: 32),
                      const Divider(height: 1),
                      const SizedBox(height: 22),
                      const Wrap(
                        spacing: 28,
                        runSpacing: 14,
                        children: [
                          _Feature(
                            Icons.widgets_outlined,
                            'Any Flutter widget',
                          ),
                          _Feature(Icons.touch_app_outlined, 'Hold to pause'),
                          _Feature(
                            Icons.tune_rounded,
                            'Your pace. Your style.',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _header(bool compact) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: DemoColors.gold.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: DemoColors.gold.withValues(alpha: 0.25)),
          ),
          child: const Icon(
            Icons.movie_filter_outlined,
            size: 20,
            color: DemoColors.gold,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'credits',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        const Text('.', style: TextStyle(fontSize: 26, color: DemoColors.gold)),
        Expanded(
          child: Text(
            compact ? 'FLUTTER' : 'A SMALL WIDGET. A LASTING IMPRESSION.',
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: DemoColors.muted,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _preview(double height) {
    return CreditsPreview(
      playback: _playback,
      duration: _duration,
      pauseOnTouch: _pauseOnTouch,
      look: _look,
      finished: _finished,
      height: height,
      onFinished: () => setState(() => _finished = true),
      onReplay: _replay,
    );
  }

  Widget _settings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: DemoColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: DemoColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Eyebrow('THE DIRECTOR’S CHAIR'),
              const SizedBox(height: 12),
              Text(
                'Make it your own.',
                style: editorialFont.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 24),
              const _SettingLabel('01', 'Appearance'),
              const SizedBox(height: 12),
              Row(
                children: [
                  for (final look in CreditLook.values) ...[
                    if (look.index > 0) const SizedBox(width: 12),
                    Expanded(
                      child: _LookOption(
                        look: look,
                        selected: _look == look,
                        onTap: () {
                          if (_look == look) return;
                          _look = look;
                          _replay();
                        },
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              const _SettingLabel('02', 'Roll duration'),
              const SizedBox(height: 12),
              SegmentedButton<int>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 16, label: Text('16 sec')),
                  ButtonSegment(value: 24, label: Text('24 sec')),
                  ButtonSegment(value: 36, label: Text('36 sec')),
                ],
                selected: {_duration},
                onSelectionChanged: (selection) {
                  _duration = selection.first;
                  _replay();
                },
                style: SegmentedButton.styleFrom(
                  foregroundColor: DemoColors.muted,
                  selectedForegroundColor: DemoColors.gold,
                  selectedBackgroundColor: DemoColors.gold.withValues(
                    alpha: 0.1,
                  ),
                  side: const BorderSide(color: DemoColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Pause on touch',
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Hold the preview to take a moment.',
                    style: TextStyle(color: DemoColors.muted, fontSize: 12),
                  ),
                  value: _pauseOnTouch,
                  onChanged: (value) => setState(() => _pauseOnTouch = value),
                  activeTrackColor: DemoColors.gold,
                  activeThumbColor: DemoColors.background,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _replay,
                icon: const Icon(Icons.replay_rounded, size: 20),
                label: const Text('Replay credits'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 8, 12, 20),
          decoration: BoxDecoration(
            border: Border.all(color: DemoColors.border),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(child: _Eyebrow('SMALL WIDGET, BIG FEELING')),
                  IconButton(
                    onPressed: _copySnippet,
                    tooltip: 'Copy widget code',
                    icon: const Icon(Icons.copy_rounded, size: 16),
                    color: DemoColors.muted,
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableText(
                  _snippet,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: DemoColors.muted,
                    height: 1.7,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LookOption extends StatelessWidget {
  const _LookOption({
    required this.look,
    required this.selected,
    required this.onTap,
  });

  final CreditLook look;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      child: Material(
        color: look.background,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? DemoColors.gold : DemoColors.border,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Aa',
                  style: editorialFont.copyWith(
                    color: look.foreground,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    look.label,
                    style: TextStyle(color: look.foreground, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: DemoColors.gold,
        fontSize: 9,
        letterSpacing: 1.8,
        fontWeight: FontWeight.w600,
        height: 1.5,
      ),
    );
  }
}

class _SettingLabel extends StatelessWidget {
  const _SettingLabel(this.number, this.label);

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          number,
          style: const TextStyle(color: DemoColors.muted, fontSize: 10),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: DemoColors.gold),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(color: DemoColors.muted, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
