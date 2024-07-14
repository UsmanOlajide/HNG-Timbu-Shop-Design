import 'dart:convert';

import 'package:intl/intl.dart';

class Shoe {
  Shoe({
    required this.name,
    required this.category,
    required this.id,
    required this.photoUrls,
    required this.price,
    // required this.availableQuantity,
  });

  final String name;
  final List<dynamic> category;
  final String id;
  final List<String> photoUrls;
  final Map<String, dynamic> price;
  // final int availableQuantity;

  @override
  String toString() {
    return 'Shoe(name: $name, id: $id)';
  }

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      name: map['name'] as String,
      category: (map['categories'] as List)
          .cast<Map<String, dynamic>>()
          .map((category) {
        return category['name'];
      }).toList(),
      id: map['id'] as String,
      photoUrls: (map['photos'] as List).map((photo) {
        return '$imageUrl/${photo['url']}';
      }).toList(),
      price: ((map['current_price'] ?? []) as List).firstOrNull ?? {},
      // availableQuantity:  map['available_quantity'] as int,
    );
  }

  String get formattedPrice {
    var newFormattedPrice = '';
    final currencyFormat = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦ ',
      decimalDigits: 2,
    );
    price.forEach(
      (key, value) {
        newFormattedPrice =
            currencyFormat.format((value as List).first as double);
      },
    );
    return newFormattedPrice;
  }

  String get discountPrice {
    var newDiscountPrice = '';
    final currencyFormat = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦ ',
      decimalDigits: 2,
    );
    price.forEach(
      (key, value) {
        final discountValue = (value as List).first as double;
        final discount = discountValue - 4000;

        newDiscountPrice =
            currencyFormat.format(discount);
      },
    );
    return newDiscountPrice;
  }

  factory Shoe.fromJson(String source) =>
      Shoe.fromMap(json.decode(source) as Map<String, dynamic>);
}

const imageUrl = 'https://api.timbu.cloud/images';
