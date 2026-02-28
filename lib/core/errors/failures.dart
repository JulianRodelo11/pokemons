/// Representación de fallos en la capa de dominio.
abstract class Failure {
  const Failure(this.message);
  final String message;
}
