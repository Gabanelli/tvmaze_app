abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() {
    return '($runtimeType) $message';
  }
}

class ApiFailure extends Failure {
  ApiFailure(super.message);
}

class InternalFailure extends Failure {
  StackTrace stackTrace;

  InternalFailure(super.message) : stackTrace = StackTrace.current;

  @override
  String toString() {
    return '${super.toString()} at:\n$stackTrace';
  }
}
