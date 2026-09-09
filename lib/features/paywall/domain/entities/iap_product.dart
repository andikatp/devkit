class IapProduct {
  const new({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rawPrice,
    required this.currencyCode,
  });

  final String id;
  final String title;
  final String description;
  final String price;
  final double rawPrice;
  final String currencyCode;

  String get displayTitle {
    final cleanTitle = title.split(' (').first.trim();
    if (cleanTitle.contains(price)) return cleanTitle;
    return '$price • $cleanTitle';
  }

  static const IapProduct coffeeFallback = IapProduct(
    id: 'devkit_pro_coffee',
    title: 'Buy a Coffee',
    description: 'Supporter badge & instant Pro access',
    price: r'$1.00',
    rawPrice: 1,
    currencyCode: 'USD',
  );

  static const IapProduct licenseFallback = IapProduct(
    id: 'devkit_pro_license',
    title: 'Pro License',
    description: 'Unlock all Pro Tools + Direct ADB toggles permanently',
    price: r'$5.00',
    rawPrice: 5,
    currencyCode: 'USD',
  );

  static const IapProduct supporterFallback = IapProduct(
    id: 'devkit_pro_supporter',
    title: 'Super Supporter',
    description: 'Super Supporter badge & lifetime Pro access',
    price: r'$15.00',
    rawPrice: 15,
    currencyCode: 'USD',
  );
}
