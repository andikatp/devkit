extension ExceptionX on Exception {
  String get getMessage {
    final str = toString();
    if (str.startsWith('Exception: ')) {
      return str.substring(11);
    }
    return str;
  }
}
