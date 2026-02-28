/// Entidad de dominio: Pokémon (ítem de lista).
class Pokemon {
  const Pokemon({
    required this.id,
    required this.name,
    required this.url,
  });
  final int id;
  final String name;
  final String url;
}
