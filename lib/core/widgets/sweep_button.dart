import 'package:flutter/material.dart';

import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/core/theme/sweep_splash.dart';

/// Botón que usa [InkWell] con splash de barrido y espera a que termine
/// la animación antes de ejecutar [onPressed].
class SweepButton extends StatefulWidget {
  const SweepButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.splashFactory = const SweepSplashFactory(),
  });

  final VoidCallback? onPressed;
  final Widget child;
  final InteractiveInkFeatureFactory splashFactory;

  @override
  State<SweepButton> createState() => _SweepButtonState();
}

class _SweepButtonState extends State<SweepButton> {
  DateTime? _tapDownTime;

  void _onTapDown(TapDownDetails details) {
    _tapDownTime = DateTime.now();
  }

  void _onTap() {
    final onPressed = widget.onPressed;
    if (onPressed == null) return;

    final tapDownTime = _tapDownTime;
    if (tapDownTime != null) {
      final elapsed = DateTime.now().difference(tapDownTime).inMilliseconds;
      final remaining =
          (sweepSplashDurationMs - elapsed).clamp(0, sweepSplashDurationMs);
      if (remaining > 0) {
        Future<void>.delayed(Duration(milliseconds: remaining), onPressed);
      } else {
        onPressed();
      }
    } else {
      onPressed();
    }
  }

  void _onTapCancel() {
    _tapDownTime = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.primary,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: widget.onPressed != null ? _onTap : null,
        onTapDown: widget.onPressed != null ? _onTapDown : null,
        onTapCancel: _onTapCancel,
        splashFactory: widget.splashFactory,
        overlayColor: WidgetStateProperty.all(
          Color.lerp(colorScheme.primary, Colors.white, 0.2)!
              .withValues(alpha: 0.35),
        ),
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: DefaultTextStyle(
              style: AppTypography.buttonLabel.copyWith(
                color: colorScheme.onPrimary,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
