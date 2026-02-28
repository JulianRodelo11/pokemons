import 'package:flutter/material.dart';

/// Tipo de animación para transiciones de navegación.
enum AnimationType {
  slideUp,
  slideLeft,
  slideRight,
  fade,
}

/// Servicio centralizado de navegación. Permite navegar y controlar
/// animaciones sin depender de [BuildContext].
class NavigationService {
  // ============================================================================
  // PROPERTIES
  // ============================================================================

  final GlobalKey<NavigatorState> navigatorKey;

  // ============================================================================
  // CONSTRUCTOR
  // ============================================================================

  NavigationService(this.navigatorKey);

  // ============================================================================
  // PUBLIC METHODS
  // ============================================================================

  /// Push de una pantalla con [MaterialPageRoute] por defecto.
  Future<T?> navigatePushMaterial<T>(Widget widget) {
    return navigatorKey.currentState!.push<T>(
      MaterialPageRoute<T>(builder: (BuildContext context) => widget),
    );
  }

  /// Push por nombre de ruta (usa [onGenerateRoute]).
  Future<T?> navigateTo<T>(String routeName) {
    return navigatorKey.currentState!.pushNamed<T>(routeName);
  }

  /// Push por nombre con argumentos.
  Future<T?> navigateToWithArguments<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  /// Reemplaza la ruta actual por [routeName].
  Future<T?> navigateReplace<T>(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed<T, dynamic>(routeName);
  }

  /// Borra la pila y deja solo [routeName].
  Future<T?> navigateAndRemoveUntil<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  /// Reemplaza la pantalla actual por [widget] con animación personalizada.
  Future<T?> navigate<T>(
    Widget widget, {
    AnimationType animationType = AnimationType.slideRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return navigatorKey.currentState!.pushReplacement<T, dynamic>(
      _buildPageRoute(widget, animationType, duration, curve),
    );
  }

  /// Push de [widget] con animación personalizada.
  Future<T?> navigatePush<T>(
    Widget widget, {
    AnimationType animationType = AnimationType.slideRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return navigatorKey.currentState!.push<T>(
      _buildPageRoute(widget, animationType, duration, curve),
    );
  }

  /// Vuelve atrás.
  void goBack<T>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }

  /// Indica si se puede hacer pop.
  bool canGoBack() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  // ============================================================================
  // PRIVATE METHODS
  // ============================================================================

  PageRoute<T> _buildPageRoute<T>(
    Widget widget,
    AnimationType animationType,
    Duration duration,
    Curve curve,
  ) {
    return PageRouteBuilder<T>(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          widget,
      transitionDuration: duration,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        final CurvedAnimation curvedAnimation =
            CurvedAnimation(parent: animation, curve: curve);
        switch (animationType) {
          case AnimationType.slideUp:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          case AnimationType.slideLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          case AnimationType.slideRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          case AnimationType.fade:
            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
        }
      },
    );
  }
}
