import 'package:flutter/material.dart';

import 'package:pokemons/core/theme/app_colors.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/core/theme/sweep_splash.dart';

/// Estilo visual del [SweepButton].
enum SweepButtonVariant {
  /// Fondo primario (azul), texto blanco.
  primary,
  /// Fondo gris secundario, texto oscuro (ej. cancelar).
  secondary,
}

/// Botón que usa [InkWell] con splash de barrido y espera a que termine
/// la animación antes de ejecutar [onPressed].
class SweepButton extends StatefulWidget {
  const SweepButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.onTapDown,
    this.variant = SweepButtonVariant.primary,
    this.splashFactory = const SweepSplashFactory(),
  });

  final VoidCallback? onPressed;
  final Widget child;
  /// Se invoca en el mismo momento del tap (junto con el efecto de barrido).
  final VoidCallback? onTapDown;
  final SweepButtonVariant variant;
  final InteractiveInkFeatureFactory splashFactory;

  @override
  State<SweepButton> createState() => _SweepButtonState();
}

class _SweepButtonState extends State<SweepButton> {
  DateTime? _tapDownTime;

  void _onTapDown(TapDownDetails details) {
    _tapDownTime = DateTime.now();
    widget.onTapDown?.call();
  }

  void _onTap() {
    final onPressed = widget.onPressed;
    if (onPressed == null) return;

    final DateTime? tapDownTime = _tapDownTime;
    if (tapDownTime != null) {
      final elapsed = DateTime.now().difference(tapDownTime).inMilliseconds;
      final int remaining = (sweepSplashDurationMs - elapsed).clamp(
        0,
        sweepSplashDurationMs,
      );
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
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isSecondary = widget.variant == SweepButtonVariant.secondary;
    final Color backgroundColor =
        isSecondary ? AppColors.secondaryAction : colorScheme.primary;
    final Color foregroundColor =
        isSecondary ? AppColors.onSurface : colorScheme.onPrimary;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: widget.onPressed != null ? _onTap : null,
        onTapDown: widget.onPressed != null ? _onTapDown : null,
        onTapCancel: _onTapCancel,
        splashFactory: widget.splashFactory,
        splashColor: isSecondary ? AppColors.onSurface : Colors.white,
        overlayColor: WidgetStateProperty.all(
          Color.lerp(
            backgroundColor,
            isSecondary ? AppColors.onSurface : Colors.white,
            0.2,
          )!.withValues(alpha: 0.35),
        ),
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: DefaultTextStyle(
              style: AppTypography.buttonLabel.copyWith(
                color: foregroundColor,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
