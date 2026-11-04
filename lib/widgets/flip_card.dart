import 'dart:math';

import 'package:flutter/material.dart';

/// Thẻ lật 3D giữa mặt trước và mặt sau.
/// Dùng ValueKey khác nhau cho mỗi thẻ để thẻ mới luôn bắt đầu ở mặt trước.
class FlipCard extends StatelessWidget {
  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    required this.showBack,
  });

  final Widget front;
  final Widget back;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: showBack ? pi : 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      builder: (context, angle, _) {
        final isBack = angle > pi / 2;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: isBack
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: back,
                )
              : front,
        );
      },
    );
  }
}
