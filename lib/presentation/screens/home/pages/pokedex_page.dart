import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/core/theme/app_colors.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';
import 'package:pokemons/presentation/widgets/filter_sheet.dart';
import 'package:pokemons/presentation/widgets/home_search_bar.dart';
import 'package:pokemons/presentation/widgets/pokemon_card.dart';
import 'package:pokemons/core/constants/app_constants.dart';

class PokedexPage extends ConsumerStatefulWidget {
  const PokedexPage({super.key});

  @override
  ConsumerState<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends ConsumerState<PokedexPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(
        () => _searchQuery = _searchController.text.trim().toLowerCase(),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDetail(BuildContext context, String name, int listIndex) {
    Navigator.of(context).pushNamed(
      AppRoutes.detail,
      arguments: <String, dynamic>{'name': name, 'heroTagSuffix': listIndex},
    );
  }

  Future<void> _openFilterSheet(BuildContext context) async {
    final Set<String> current = ref.read(selectedFilterTypesProvider);
    final Set<String>? result = await FilterSheet.show(
      context,
      initialSelected: current,
    );
    if (result != null && mounted) {
      ref.read(selectedFilterTypesProvider.notifier).setTypes(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final AsyncValue<List<Pokemon>> asyncPokemonList = ref.watch(
      pokemonListProvider,
    );
    final selectedTypes = ref.watch(selectedFilterTypesProvider);

    return asyncPokemonList.when(
      data: (List<Pokemon> _) {
        final AsyncValue<List<Pokemon>> asyncFilteredList = ref.watch(
          filteredByTypesPokemonListProvider,
        );
        return asyncFilteredList.when(
          data: (List<Pokemon> listByType) {
            final List<Pokemon> filtered = listByType
                .where((p) => p.name.toLowerCase().contains(_searchQuery))
                .toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 16),
                HomeSearchBar(
                  controller: _searchController,
                  hint: l10n.homeSearchHint,
                  onSearchButtonTap: () => _openFilterSheet(context),
                ),
                if (selectedTypes.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: l10n.filterResultsCountPrefix,
                                style: AppTypography.bodyMediumMd.copyWith(
                                  color: AppColors.textDisable,
                                ),
                              ),
                              TextSpan(
                                text: '${filtered.length}',
                                style: AppTypography.bodyBoldMd.copyWith(
                                  color: AppColors.textDisable,
                                ),
                              ),
                              TextSpan(
                                text: l10n.filterResultsCountSuffix,
                                style: AppTypography.bodyBoldMd.copyWith(
                                  color: AppColors.textDisable,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(selectedFilterTypesProvider.notifier)
                                .clear();
                          },
                          child: Text(
                            l10n.filterClear,
                            style: AppTypography.bodyMediumMdUnderline.copyWith(
                              color: AppColors.primary,
                              decorationColor: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            l10n.homeEmptyList,
                            style: AppTypography.bodyMedium.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 32,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final pokemon = filtered[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: PokemonCard(
                                pokemon: pokemon,
                                listIndex: index,
                                onTap:
                                    () => _openDetail(
                                      context,
                                      pokemon.name,
                                      index,
                                    ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
          loading:
              () => _buildPokedexLoading(
                context,
                l10n,
                isFilterLoading: selectedTypes.isNotEmpty,
              ),
          error: (Object err, StackTrace? stackTrace) => _buildErrorState(l10n),
        );
      },
      loading:
          () => _buildPokedexLoading(
            context,
            l10n,
            isFilterLoading: selectedTypes.isNotEmpty,
          ),
      error: (Object err, StackTrace? stackTrace) => _buildErrorState(l10n),
    );
  }

  Widget _buildErrorState(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 16),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/3.0x/Magikarp_Jump_Pattern_01_1.png',
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                          Icons.error_outline,
                          size: 80,
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.homeErrorTitle,
                    textAlign: TextAlign.center,
                    style: AppTypography.headingMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.homeErrorDescription,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        AppConstants.forcePokemonListError = false;
                        ref.invalidate(pokemonListFutureProvider);
                        ref.invalidate(pokemonListProvider);
                        ref.invalidate(filteredByTypesPokemonListProvider);
                      },
                      child: Text(l10n.homeErrorRetry),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPokedexLoading(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isFilterLoading,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 16),
        HomeSearchBar(
          controller: _searchController,
          hint: l10n.homeSearchHint,
          onSearchButtonTap: () => _openFilterSheet(context),
        ),
        if (isFilterLoading) ...[
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.homeLoading,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
