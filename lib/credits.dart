import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  const Credits({
    Key? key,
    required this.children,
    this.onFinished,
    this.duration = const Duration(seconds: 10),
    this.delay = const Duration(milliseconds: 300),
    this.backgroundColor = Colors.black,
    this.curve = Curves.linear,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.pauseOnTouch = true,
  }) : super(key: key);

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

  ///
  final Curve curve;

  ///
  final CrossAxisAlignment crossAxisAlignment;

  ///
  final bool pauseOnTouch;

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(widget.delay).then(
      (value) => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: widget.duration,
        curve: widget.curve,
      ),
    );
    scrollController.addListener(_onScrollChanged);
    super.initState();
  }

  @override
  void dispose() {
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
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height,
              bottom: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: widget.crossAxisAlignment,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }

  void _pause() {
    if (!widget.pauseOnTouch) return;

    final offset = scrollController.offset;
    scrollController.animateTo(
      offset,
      duration: Duration.zero,
      curve: widget.curve,
    );
  }

  void _continue() {
    if (!widget.pauseOnTouch) return;
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final duration = widget.duration;
    final pixelDuration = duration.inMilliseconds / maxScrollExtent;
    final remaining = maxScrollExtent - scrollController.offset;
    final remainingMS = (remaining * pixelDuration).toInt();

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: remainingMS),
      curve: widget.curve,
    );
  }

  void _onScrollChanged() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (widget.onFinished != null) {
        widget.onFinished!();
      }
    }
  }
}
