/// Entidad de dominio: detalle de un Pokémon.
class PokemonDetail {
  const PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
  });
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<String> types;
  final Map<String, int> stats;
}
