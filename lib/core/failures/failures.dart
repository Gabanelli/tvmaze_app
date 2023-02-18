abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ApiFailure extends Failure {
  ApiFailure(super.message);
}
