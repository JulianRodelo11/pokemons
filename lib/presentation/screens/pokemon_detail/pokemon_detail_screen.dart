import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/pokemon_detail_provider.dart';

/// Pantalla de detalle de un Pokémon.
class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetail = ref.watch(pokemonDetailProvider(name));
    return Scaffold(
      appBar: AppBar(
        title: Text(_capitalize(name)),
        centerTitle: true,
      ),
      body: asyncDetail.when(
        data: (detail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (detail.imageUrl.isNotEmpty)
                Image.network(
                  detail.imageUrl,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (_, Object error, StackTrace? stackTrace) =>
                      const Icon(Icons.broken_image, size: 200),
                )
              else
                const Icon(Icons.image_not_supported, size: 200),
              const SizedBox(height: 24),
              Text(
                _capitalize(detail.name),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.detailHeightWeight(
                  detail.height,
                  detail.weight,
                ),
              ),
              if (detail.types.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: detail.types
                      .map((t) => Chip(label: Text(_capitalize(t))))
                      .toList(),
                ),
              ],
              if (detail.stats.isNotEmpty) ...[
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.detailStats,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                ...detail.stats.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(_capitalize(e.key)),
                        ),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (e.value / 255).clamp(0.0, 1.0),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${e.value}'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.detailError(err.toString()),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';
  }
}
