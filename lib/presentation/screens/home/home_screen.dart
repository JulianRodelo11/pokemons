import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';

/// Pantalla principal (lista de Pokémon).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> asyncList = ref.watch(pokemonListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: asyncList.when(
        data: (List<Pokemon> list) => list.isEmpty
            ? Center(child: Text(AppLocalizations.of(context)!.homeEmptyList))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final pokemon = list[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: Text(
                        '${pokemon.id}',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    title: Text(
                      _capitalize(pokemon.name),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onTap: () => _openDetail(context, pokemon.name),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object err, StackTrace? _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.homeError(err.toString()),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, String name) {
    Navigator.of(context).pushNamed(
      AppRoutes.detail,
      arguments: name,
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';
  }
}
