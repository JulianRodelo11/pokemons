import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/locale_provider.dart';
import 'package:pokemons/presentation/screens/home/pages/favoritos_page.dart';
import 'package:pokemons/presentation/screens/home/pages/perfil_page.dart';
import 'package:pokemons/presentation/screens/home/pages/pokedex_page.dart';
import 'package:pokemons/presentation/screens/home/pages/regiones_page.dart';
import 'package:pokemons/presentation/widgets/home_bottom_nav.dart';

/// Pantalla principal: navegación entre Pokedex, Regiones, Favoritos y Perfil.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedNavIndex,
          children: const <Widget>[
            PokedexPage(),
            RegionesPage(),
            FavoritosPage(),
            PerfilPage(),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNav(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            HomeNavItem(
              svgAsset: 'assets/svg/house.svg',
              label: l10n.navPokedex,
              selected: _selectedNavIndex == 0,
              onTap: () => setState(() => _selectedNavIndex = 0),
            ),
            HomeNavItem(
              svgAsset: 'assets/svg/globe.svg',
              label: l10n.navRegiones,
              selected: _selectedNavIndex == 1,
              onTap: () => setState(() => _selectedNavIndex = 1),
            ),
            HomeNavItem(
              svgAsset: 'assets/svg/heart.fill.svg',
              label: l10n.navFavoritos,
              selected: _selectedNavIndex == 2,
              onTap: () => setState(() => _selectedNavIndex = 2),
            ),
            HomeNavItem(
              svgAsset: 'assets/svg/user.svg',
              label: l10n.navPerfil,
              selected: _selectedNavIndex == 3,
              onTap: () => setState(() => _selectedNavIndex = 3),
            ),
          ],
        ),
      ),
    );
  }
}