/// Utilidades estáticas para strings.
abstract class StringUtils {
  StringUtils._();

  /// Primera letra en mayúscula y el resto en minúscula.
  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';
  }
}
