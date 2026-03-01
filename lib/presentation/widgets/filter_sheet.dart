import 'package:flutter/material.dart';
import 'package:pokemons/core/theme/theme.dart';
import 'package:pokemons/core/utils/pokemon_utils.dart';
import 'package:pokemons/l10n/app_localizations.dart';

/// Altura fija del bottom sheet de filtros.
const double _kFilterSheetHeight = 614;

/// Nombres para mostrar en el filtro (con acentos cuando aplica).
const Map<String, String> _typeFilterDisplayNames = <String, String>{
  'electric': 'Eléctrico',
  'dragon': 'Dragón',
};

String _typeDisplayName(String typeKey) {
  return _typeFilterDisplayNames[typeKey] ??
      PokemonUtils.typeDisplayName(typeKey);
}

/// Bottom sheet "Filtra por tus preferencias": tipo con checkboxes, Aplicar y Cancelar.
class FilterSheet extends StatefulWidget {
  const FilterSheet({
    super.key,
    required this.initialSelectedTypes,
    required this.onApply,
  });

  final Set<String> initialSelectedTypes;
  final void Function(Set<String> selectedTypes) onApply;

  /// Muestra el sheet como modal y devuelve los tipos seleccionados al aplicar (o null si cancela).
  static Future<Set<String>?> show(
    BuildContext context, {
    Set<String>? initialSelected,
  }) {
    return showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => FilterSheet(
        initialSelectedTypes: initialSelected ?? <String>{},
        onApply: (Set<String> selected) => Navigator.of(context).pop(selected),
      ),
    );
  }

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late Set<String> _selected;
  bool _isTypeSectionExpanded = true;

  @override
  void initState() {
    super.initState();
    _selected = Set<String>.from(widget.initialSelectedTypes);
  }

  void _toggleTypeSection() {
    setState(() => _isTypeSectionExpanded = !_isTypeSectionExpanded);
  }

  void _toggle(String typeKey) {
    setState(() {
      if (_selected.contains(typeKey)) {
        _selected.remove(typeKey);
      } else {
        _selected.add(typeKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Container(
      height: _kFilterSheetHeight,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    foregroundColor: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Text(
            l10n.filterSheetTitle,
            textAlign: TextAlign.center,
            style: AppTypography.heading2xl.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            l10n.filterSheetTypeLabel,
            isExpanded: _isTypeSectionExpanded,
            onTap: _toggleTypeSection,
          ),
          Expanded(
            child: _isTypeSectionExpanded
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: PokemonUtils.filterTypeKeys.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String typeKey = PokemonUtils.filterTypeKeys[index];
                      final bool isSelected = _selected.contains(typeKey);
                      return _buildTypeRow(
                        label: _typeDisplayName(typeKey),
                        selected: isSelected,
                        onTap: () => _toggle(typeKey),
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.shadow,
                  offset: Offset(0, -1),
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => widget.onApply(_selected),
                      child: Text(l10n.filterApply),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.secondaryAction,
                        foregroundColor: AppColors.onSurface,
                        side: BorderSide.none,
                      ),
                      child: Text(l10n.filterCancel),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String label, {
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: <Widget>[
                  Text(
                    label,
                    style: AppTypography.bodySemiBoldLg.copyWith(
                      color: AppColors.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.onSurface,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
        ],
      ),
    );
  }

  Widget _buildTypeRow({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMediumMd.copyWith(
                  color: AppColors.onSurface,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}