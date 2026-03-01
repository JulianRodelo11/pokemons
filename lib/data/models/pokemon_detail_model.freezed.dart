// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PokemonDetailModel {

 int get id; String get name; String get imageUrl; int get height; int get weight; List<String> get types; Map<String, int> get stats; String get category; List<String> get abilities; Map<String, List<String>> get abilityNamesByLocale; double? get maleRatio; double? get femaleRatio; String get description;
/// Create a copy of PokemonDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokemonDetailModelCopyWith<PokemonDetailModel> get copyWith => _$PokemonDetailModelCopyWithImpl<PokemonDetailModel>(this as PokemonDetailModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokemonDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&const DeepCollectionEquality().equals(other.types, types)&&const DeepCollectionEquality().equals(other.stats, stats)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.abilities, abilities)&&const DeepCollectionEquality().equals(other.abilityNamesByLocale, abilityNamesByLocale)&&(identical(other.maleRatio, maleRatio) || other.maleRatio == maleRatio)&&(identical(other.femaleRatio, femaleRatio) || other.femaleRatio == femaleRatio)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl,height,weight,const DeepCollectionEquality().hash(types),const DeepCollectionEquality().hash(stats),category,const DeepCollectionEquality().hash(abilities),const DeepCollectionEquality().hash(abilityNamesByLocale),maleRatio,femaleRatio,description);

@override
String toString() {
  return 'PokemonDetailModel(id: $id, name: $name, imageUrl: $imageUrl, height: $height, weight: $weight, types: $types, stats: $stats, category: $category, abilities: $abilities, abilityNamesByLocale: $abilityNamesByLocale, maleRatio: $maleRatio, femaleRatio: $femaleRatio, description: $description)';
}


}

/// @nodoc
abstract mixin class $PokemonDetailModelCopyWith<$Res>  {
  factory $PokemonDetailModelCopyWith(PokemonDetailModel value, $Res Function(PokemonDetailModel) _then) = _$PokemonDetailModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String imageUrl, int height, int weight, List<String> types, Map<String, int> stats, String category, List<String> abilities, Map<String, List<String>> abilityNamesByLocale, double? maleRatio, double? femaleRatio, String description
});




}
/// @nodoc
class _$PokemonDetailModelCopyWithImpl<$Res>
    implements $PokemonDetailModelCopyWith<$Res> {
  _$PokemonDetailModelCopyWithImpl(this._self, this._then);

  final PokemonDetailModel _self;
  final $Res Function(PokemonDetailModel) _then;

/// Create a copy of PokemonDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? height = null,Object? weight = null,Object? types = null,Object? stats = null,Object? category = null,Object? abilities = null,Object? abilityNamesByLocale = null,Object? maleRatio = freezed,Object? femaleRatio = freezed,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as Map<String, int>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,abilities: null == abilities ? _self.abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<String>,abilityNamesByLocale: null == abilityNamesByLocale ? _self.abilityNamesByLocale : abilityNamesByLocale // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,maleRatio: freezed == maleRatio ? _self.maleRatio : maleRatio // ignore: cast_nullable_to_non_nullable
as double?,femaleRatio: freezed == femaleRatio ? _self.femaleRatio : femaleRatio // ignore: cast_nullable_to_non_nullable
as double?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PokemonDetailModel].
extension PokemonDetailModelPatterns on PokemonDetailModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokemonDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokemonDetailModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokemonDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _PokemonDetailModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokemonDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _PokemonDetailModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String imageUrl,  int height,  int weight,  List<String> types,  Map<String, int> stats,  String category,  List<String> abilities,  Map<String, List<String>> abilityNamesByLocale,  double? maleRatio,  double? femaleRatio,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokemonDetailModel() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.height,_that.weight,_that.types,_that.stats,_that.category,_that.abilities,_that.abilityNamesByLocale,_that.maleRatio,_that.femaleRatio,_that.description);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String imageUrl,  int height,  int weight,  List<String> types,  Map<String, int> stats,  String category,  List<String> abilities,  Map<String, List<String>> abilityNamesByLocale,  double? maleRatio,  double? femaleRatio,  String description)  $default,) {final _that = this;
switch (_that) {
case _PokemonDetailModel():
return $default(_that.id,_that.name,_that.imageUrl,_that.height,_that.weight,_that.types,_that.stats,_that.category,_that.abilities,_that.abilityNamesByLocale,_that.maleRatio,_that.femaleRatio,_that.description);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String imageUrl,  int height,  int weight,  List<String> types,  Map<String, int> stats,  String category,  List<String> abilities,  Map<String, List<String>> abilityNamesByLocale,  double? maleRatio,  double? femaleRatio,  String description)?  $default,) {final _that = this;
switch (_that) {
case _PokemonDetailModel() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.height,_that.weight,_that.types,_that.stats,_that.category,_that.abilities,_that.abilityNamesByLocale,_that.maleRatio,_that.femaleRatio,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _PokemonDetailModel extends PokemonDetailModel {
  const _PokemonDetailModel({required this.id, required this.name, required this.imageUrl, required this.height, required this.weight, required final  List<String> types, required final  Map<String, int> stats, this.category = '', final  List<String> abilities = const [], final  Map<String, List<String>> abilityNamesByLocale = const {}, this.maleRatio, this.femaleRatio, this.description = ''}): _types = types,_stats = stats,_abilities = abilities,_abilityNamesByLocale = abilityNamesByLocale,super._();
  

@override final  int id;
@override final  String name;
@override final  String imageUrl;
@override final  int height;
@override final  int weight;
 final  List<String> _types;
@override List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

 final  Map<String, int> _stats;
@override Map<String, int> get stats {
  if (_stats is EqualUnmodifiableMapView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_stats);
}

@override@JsonKey() final  String category;
 final  List<String> _abilities;
@override@JsonKey() List<String> get abilities {
  if (_abilities is EqualUnmodifiableListView) return _abilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abilities);
}

 final  Map<String, List<String>> _abilityNamesByLocale;
@override@JsonKey() Map<String, List<String>> get abilityNamesByLocale {
  if (_abilityNamesByLocale is EqualUnmodifiableMapView) return _abilityNamesByLocale;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_abilityNamesByLocale);
}

@override final  double? maleRatio;
@override final  double? femaleRatio;
@override@JsonKey() final  String description;

/// Create a copy of PokemonDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokemonDetailModelCopyWith<_PokemonDetailModel> get copyWith => __$PokemonDetailModelCopyWithImpl<_PokemonDetailModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokemonDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&const DeepCollectionEquality().equals(other._types, _types)&&const DeepCollectionEquality().equals(other._stats, _stats)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._abilities, _abilities)&&const DeepCollectionEquality().equals(other._abilityNamesByLocale, _abilityNamesByLocale)&&(identical(other.maleRatio, maleRatio) || other.maleRatio == maleRatio)&&(identical(other.femaleRatio, femaleRatio) || other.femaleRatio == femaleRatio)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl,height,weight,const DeepCollectionEquality().hash(_types),const DeepCollectionEquality().hash(_stats),category,const DeepCollectionEquality().hash(_abilities),const DeepCollectionEquality().hash(_abilityNamesByLocale),maleRatio,femaleRatio,description);

@override
String toString() {
  return 'PokemonDetailModel(id: $id, name: $name, imageUrl: $imageUrl, height: $height, weight: $weight, types: $types, stats: $stats, category: $category, abilities: $abilities, abilityNamesByLocale: $abilityNamesByLocale, maleRatio: $maleRatio, femaleRatio: $femaleRatio, description: $description)';
}


}

/// @nodoc
abstract mixin class _$PokemonDetailModelCopyWith<$Res> implements $PokemonDetailModelCopyWith<$Res> {
  factory _$PokemonDetailModelCopyWith(_PokemonDetailModel value, $Res Function(_PokemonDetailModel) _then) = __$PokemonDetailModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String imageUrl, int height, int weight, List<String> types, Map<String, int> stats, String category, List<String> abilities, Map<String, List<String>> abilityNamesByLocale, double? maleRatio, double? femaleRatio, String description
});




}
/// @nodoc
class __$PokemonDetailModelCopyWithImpl<$Res>
    implements _$PokemonDetailModelCopyWith<$Res> {
  __$PokemonDetailModelCopyWithImpl(this._self, this._then);

  final _PokemonDetailModel _self;
  final $Res Function(_PokemonDetailModel) _then;

/// Create a copy of PokemonDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? height = null,Object? weight = null,Object? types = null,Object? stats = null,Object? category = null,Object? abilities = null,Object? abilityNamesByLocale = null,Object? maleRatio = freezed,Object? femaleRatio = freezed,Object? description = null,}) {
  return _then(_PokemonDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as Map<String, int>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,abilities: null == abilities ? _self._abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<String>,abilityNamesByLocale: null == abilityNamesByLocale ? _self._abilityNamesByLocale : abilityNamesByLocale // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,maleRatio: freezed == maleRatio ? _self.maleRatio : maleRatio // ignore: cast_nullable_to_non_nullable
as double?,femaleRatio: freezed == femaleRatio ? _self.femaleRatio : femaleRatio // ignore: cast_nullable_to_non_nullable
as double?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
