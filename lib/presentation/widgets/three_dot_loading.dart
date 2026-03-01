import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Loading indicator con tres puntos que rebotan en secuencia:
/// primero sube el primero, luego el del medio, luego el último.
class ThreeDotLoading extends StatefulWidget {
  const ThreeDotLoading({
    super.key,
    this.color = Colors.white,
    this.size = 8,
    this.spacing = 6,
    this.bounceHeight = 6,
  });

  final Color color;
  final double size;
  final double spacing;
  final double bounceHeight;

  @override
  State<ThreeDotLoading> createState() => _ThreeDotLoadingState();
}

class _ThreeDotLoadingState extends State<ThreeDotLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _offsetYForDot(int index) {
    final double phase = _controller.value * 3;
    final int activeIndex = phase.floor() % 3;
    if (index != activeIndex) return 0;
    final double subPhase = phase % 1;
    return -widget.bounceHeight * math.sin(subPhase * math.pi);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          height: widget.size + widget.bounceHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(3, (int i) {
              final double offsetY = _offsetYForDot(i);
              return Padding(
                padding: EdgeInsets.only(right: i < 2 ? widget.spacing : 0),
                child: Transform.translate(
                  offset: Offset(0, offsetY),
                  child: SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
