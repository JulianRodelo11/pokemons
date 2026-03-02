import 'package:flutter/material.dart';
import 'package:pokemons/core/theme/app_colors.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/presentation/widgets/pokemon_card.dart';

const double _kDeleteStripMinWidth = 126;
const double _kCardHeight = 102;
const double _kDismissThresholdFraction = 0.25;
const Duration _kSnapBackDuration = Duration(milliseconds: 300);

class SwipeableFavoriteItem extends StatefulWidget {
  const SwipeableFavoriteItem({
    super.key,
    required this.maxWidth,
    required this.pokemon,
    required this.listIndex,
    required this.onTap,
    required this.onDismiss,
    this.displayNumber,
  });

  final double maxWidth;
  final Pokemon pokemon;
  final int listIndex;
  final VoidCallback onTap;
  final VoidCallback onDismiss;
  /// Número a mostrar (N°XXX) en la carta. En favoritos se pasa [pokemon].id.
  final int? displayNumber;

  @override
  State<SwipeableFavoriteItem> createState() => _SwipeableFavoriteItemState();
}

class _SwipeableFavoriteItemState extends State<SwipeableFavoriteItem>
    with SingleTickerProviderStateMixin {
  double _dragOffset = 0;
  double _snapBackFrom = 0;
  late final AnimationController _snapBackController;

  @override
  void initState() {
    super.initState();
    _snapBackController = AnimationController(
      vsync: this,
      duration: _kSnapBackDuration,
    );
  }

  @override
  void dispose() {
    _snapBackController.dispose();
    super.dispose();
  }

  double get _dismissThreshold => widget.maxWidth * _kDismissThresholdFraction;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_snapBackController.isAnimating) {
      _snapBackController.removeListener(_onSnapBackTick);
      _snapBackController.reset();
    }
    setState(() {
      _dragOffset = (_dragOffset - details.delta.dx).clamp(
        0.0,
        widget.maxWidth,
      );
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragOffset >= _dismissThreshold) {
      widget.onDismiss();
    } else {
      _snapBackFrom = _dragOffset;
      _snapBackController.forward(from: 0);
      _snapBackController.addListener(_onSnapBackTick);
    }
  }

  void _onSnapBackTick() {
    final t = Curves.easeOut.transform(_snapBackController.value);
    setState(() => _dragOffset = _snapBackFrom * (1 - t));
    if (_snapBackController.isCompleted) {
      _snapBackController.removeListener(_onSnapBackTick);
      _snapBackController.reset();
      setState(() => _dragOffset = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double redWidth = (_kDeleteStripMinWidth + _dragOffset).clamp(
      _kDeleteStripMinWidth,
      widget.maxWidth,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          top: 0,
          right: 0,
          width: redWidth,
          height: _kCardHeight,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: Transform.translate(
            offset: Offset(-_dragOffset, 0),
            child: PokemonCard(
              pokemon: widget.pokemon,
              listIndex: widget.listIndex,
              onTap: widget.onTap,
              displayNumber: widget.displayNumber,
            ),
          ),
        ),
      ],
    );
  }
}
