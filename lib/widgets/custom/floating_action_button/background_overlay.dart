import 'package:flutter/material.dart';

class BackgroundOverlay extends AnimatedWidget {
  final Color color;
  final double opacity;

  const BackgroundOverlay({
    Key key,
    Animation<double> animation,
    this.color = Colors.white,
    this.opacity = 0.9,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Container(
      color: color.withOpacity(animation.value * opacity),
    );
  }
}
