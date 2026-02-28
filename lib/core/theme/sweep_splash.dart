import 'package:flutter/material.dart';

/// Duración del barrido del splash (ms). Usar para sincronizar callbacks.
const int sweepSplashDurationMs = 350;

/// Splash que barre de derecha a izquierda al pulsar.
class SweepSplash extends InteractiveInkFeature {
  SweepSplash({
    required super.controller,
    required super.referenceBox,
    required super.color,
    required TextDirection textDirection,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    super.onRemoved,
  }) : _color = color,
       _rectCallback = rectCallback,
       _borderRadius = borderRadius ?? BorderRadius.zero {
    _sweepController =
        AnimationController(
            duration: const Duration(milliseconds: sweepSplashDurationMs),
            vsync: controller.vsync,
          )
          ..addListener(controller.markNeedsPaint)
          ..forward();

    _sweep = _sweepController.drive(CurveTween(curve: Curves.easeInOutCubic));

    _fadeController =
        AnimationController(
            duration: const Duration(milliseconds: 180),
            vsync: controller.vsync,
          )
          ..addListener(controller.markNeedsPaint)
          ..addStatusListener(_onFadeStatusChanged);

    _fade = _fadeController.drive(Tween<double>(begin: 1, end: 0));

    controller.addInkFeature(this);
  }

  final Color _color;
  final RectCallback? _rectCallback;
  final BorderRadius _borderRadius;

  static const BorderRadius _defaultButtonRadius = BorderRadius.all(
    Radius.circular(20),
  );

  late final AnimationController _sweepController;
  late final Animation<double> _sweep;

  late final AnimationController _fadeController;
  late final Animation<double> _fade;

  void _onFadeStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      dispose();
    }
  }

  void _startFadeWhenSweepDone() {
    if (_sweepController.status == AnimationStatus.completed) {
      _fadeController.forward();
    } else {
      _sweepController.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _fadeController.forward();
        }
      });
    }
  }

  @override
  void confirm() {
    _startFadeWhenSweepDone();
  }

  @override
  void cancel() {
    _startFadeWhenSweepDone();
  }

  @override
  void dispose() {
    _sweepController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Rect get _rect {
    if (_rectCallback != null) {
      return _rectCallback();
    }
    return Offset.zero & referenceBox.size;
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final Rect rect = _rect;
    final double progress = _sweep.value;
    final double alpha = _fade.value;

    if (progress <= 0 || alpha <= 0) return;

    final double w = rect.width;
    final double h = rect.height;
    // Barrido derecha → izquierda: crece desde el borde derecho.
    final double sweepWidth = w * progress;
    final double left = rect.left + (w - sweepWidth);
    final Rect sweepRect = Rect.fromLTWH(left, rect.top, sweepWidth, h);

    final BorderRadius effectiveRadius = _borderRadius == BorderRadius.zero
        ? _defaultButtonRadius
        : _borderRadius;
    final RRect clipRRect = RRect.fromRectAndCorners(
      rect,
      topLeft: effectiveRadius.topLeft,
      topRight: effectiveRadius.topRight,
      bottomLeft: effectiveRadius.bottomLeft,
      bottomRight: effectiveRadius.bottomRight,
    );

    // Gradiente suave en el borde izquierdo del sweep para transición más natural.
    final Color sweepColor = _color.withValues(alpha: _color.a * alpha);
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          sweepColor.withValues(alpha: 0),
          sweepColor.withValues(alpha: sweepColor.a * 0.4),
          sweepColor,
        ],
        stops: const [0.0, 0.35, 1.0],
      ).createShader(sweepRect);

    canvas.save();
    canvas.transform(transform.storage);
    canvas.clipRRect(clipRRect);
    canvas.drawRect(sweepRect, paint);
    canvas.restore();
  }
}

/// Factory para usar [SweepSplash] en el tema.
class SweepSplashFactory extends InteractiveInkFeatureFactory {
  const SweepSplashFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return SweepSplash(
      controller: controller,
      referenceBox: referenceBox,
      color: color,
      textDirection: textDirection,
      rectCallback: containedInkWell ? rectCallback : null,
      borderRadius: borderRadius,
      onRemoved: onRemoved,
    );
  }
}
