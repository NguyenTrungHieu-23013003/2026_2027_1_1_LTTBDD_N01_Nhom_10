import 'package:flutter/material.dart';

class PopIconButton extends StatefulWidget {
  const PopIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.tooltip,
  });

  final Widget icon;
  final Color color;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  State<PopIconButton> createState() => _PopIconButtonState();
}

class _PopIconButtonState extends State<PopIconButton> {
  bool _popped = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _popped && !MediaQuery.of(context).disableAnimations ? 1.2 : 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutBack,
      onEnd: () {
        if (_popped && mounted) setState(() => _popped = false);
      },
      child: IconButton(
        tooltip: widget.tooltip,
        color: widget.color,
        onPressed: widget.onPressed == null
            ? null
            : () {
                if (!MediaQuery.of(context).disableAnimations) {
                  setState(() => _popped = true);
                }
                widget.onPressed!();
              },
        icon: widget.icon,
      ),
    );
  }
}

class SwayIcon extends StatefulWidget {
  const SwayIcon({super.key, required this.icon});

  final Widget icon;

  @override
  State<SwayIcon> createState() => SwayIconState();
}

class SwayIconState extends State<SwayIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 360),
    vsync: this,
  );
  late final Animation<double> _rotation = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(begin: 0, end: -0.12).chain(
        CurveTween(curve: Curves.easeOut),
      ),
      weight: 25,
    ),
    TweenSequenceItem(
      tween: Tween(begin: -0.12, end: 0.12).chain(
        CurveTween(curve: Curves.easeInOut),
      ),
      weight: 40,
    ),
    TweenSequenceItem(
      tween: Tween<double>(begin: 0.12, end: 0).chain(
        CurveTween(curve: Curves.easeOut),
      ),
      weight: 35,
    ),
  ]).animate(_controller);

  void sway() {
    if (MediaQuery.of(context).disableAnimations) return;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      child: widget.icon,
      builder: (context, child) =>
          Transform.rotate(angle: _rotation.value, child: child),
    );
  }
}
