import 'dart:async';

import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  const Credits({
    super.key,
    required this.children,
    this.onFinished,
    this.duration = const Duration(seconds: 10),
    this.delay = const Duration(milliseconds: 300),
    this.backgroundColor = Colors.black,
    this.curve = Curves.linear,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.pauseOnTouch = true,
  });

  /// You have to give here the widgets that will be included in the scroll action.
  final List<Widget> children;

  /// You can use this function for the operations to be performed when the scrolling process is completed.
  final Function()? onFinished;

  /// You can set the playing time of the swipe here.
  final Duration duration;

  /// You can set the delay time of the scroll here.
  final Duration delay;

  /// You can edit the background color here.
  final Color backgroundColor;

  /// Lets you specify the type of animation curve.
  final Curve curve;

  /// Lets you specify how children are placed along the cross axis in a flexible layout.
  final CrossAxisAlignment crossAxisAlignment;

  /// When the screen is pressed, it stops the credits.
  final bool pauseOnTouch;

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  final scrollController = ScrollController();
  Timer? _startTimer;
  bool _started = false;
  bool _paused = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScrollChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _startTimer = Timer(widget.delay, () {
        _started = true;
        if (!_paused) _animateToEnd();
      });
    });
  }

  @override
  void dispose() {
    _startTimer?.cancel();
    scrollController
      ..removeListener(_onScrollChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: _continue,
      onTapDown: (_) => _pause(),
      onTapUp: (_) => _continue(),
      child: Container(
        color: widget.backgroundColor,
        constraints: const BoxConstraints.expand(),
        child: LayoutBuilder(
          builder:
              (context, constraints) => SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: widget.crossAxisAlignment,
                    children: widget.children,
                  ),
                ),
              ),
        ),
      ),
    );
  }

  void _pause() {
    if (!widget.pauseOnTouch || _finished) return;

    _paused = true;
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.offset);
    }
  }

  void _continue() {
    if (!_paused) return;
    _paused = false;
    if (_started) _animateToEnd();
  }

  void _animateToEnd() {
    if (!mounted || !scrollController.hasClients || _finished) return;
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final remaining = maxScrollExtent - scrollController.offset;
    if (maxScrollExtent <= 0 || remaining <= 0) {
      _onScrollChanged();
      return;
    }
    final remainingDuration = Duration(
      microseconds:
          (widget.duration.inMicroseconds * remaining / maxScrollExtent)
              .round(),
    );
    if (remainingDuration <= Duration.zero) {
      scrollController.jumpTo(maxScrollExtent);
      return;
    }

    scrollController.animateTo(
      maxScrollExtent,
      duration: remainingDuration,
      curve: widget.curve,
    );
  }

  void _onScrollChanged() {
    if (!_finished &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _finished = true;
      widget.onFinished?.call();
    }
  }
}
