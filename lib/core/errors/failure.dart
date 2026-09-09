abstract class Failure {
  const new({required this.message, this.code});

  final String message;
  final String? code;
}

class PlatformFailure extends Failure {
  const new({required super.message, super.code});
}
