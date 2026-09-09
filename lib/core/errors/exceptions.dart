class CustomPlatformException implements Exception {
  const new({required this.message, this.code});

  final String message;
  final String? code;
}
