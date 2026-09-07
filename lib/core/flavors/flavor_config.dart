enum FlavorType { free, pro }

class FlavorValues {
  const new({this.titleApp = 'DEVKIT Free'});

  final String titleApp;
}

class FlavorConfig {
  new _privateConstructor({
    this.flavor = FlavorType.free,
    this.values = const FlavorValues(),
  });

  static bool _initialized = false;

  static FlavorConfig? _instance;

  static void reset() {
    _instance = null;
    _initialized = false;
  }

  static void initialize({
    FlavorType flavor = FlavorType.free,
    FlavorValues values = const FlavorValues(),
  }) {
    if (_initialized) {
      throw StateError('FlavorConfig has already been initialized.');
    }
    _instance = ._privateConstructor(flavor: flavor, values: values);
    _initialized = true;
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw StateError(
        'FlavorConfig has not been initialized. Call initialize() first.',
      );
    }
    return _instance!;
  }

  final FlavorType flavor;
  final FlavorValues values;
}
