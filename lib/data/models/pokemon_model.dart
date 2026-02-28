import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokemons/domain/entities/pokemon.dart';

part 'pokemon_model.freezed.dart';

@freezed
abstract class PokemonModel with _$PokemonModel {
  const PokemonModel._();
  const factory PokemonModel({
    required int id,
    required String name,
    required String url,
  }) = _PokemonModel;

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String? ?? '';
    final id = _parseIdFromUrl(url);
    return PokemonModel(
      id: id,
      name: json['name'] as String? ?? '',
      url: url,
    );
  }

  Pokemon toEntity() => Pokemon(id: id, name: name, url: url);

  static int _parseIdFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return 0;
    final segments = uri.pathSegments;
    if (segments.isEmpty) return 0;
    final last = segments.last;
    return int.tryParse(last) ?? 0;
  }
}
