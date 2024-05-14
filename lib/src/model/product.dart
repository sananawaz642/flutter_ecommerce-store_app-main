import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_commerce_flutter/src/model/product_size_type.dart';

enum ProductType { all, shirts, flat, blazers, trousers, dupata }

class Product {
  String name;
  int price;
  int? off;
  String about;
  bool isAvailable;
  ProductSizeType? sizes;
  int _quantity;
  List<String> images;
  bool isFavorite;
  double rating;
  ProductType type;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Product({
    required int quantity,
    required this.name,
    required this.price,
    required this.off,
    required this.about,
    required this.isAvailable,
    required this.images,
    required this.isFavorite,
    required this.rating,
    required this.type,
    required this.sizes
  }) : _quantity = quantity;

  Product copyWith({
    String? name,
    int? price,
    int? off,
    String? about,
    bool? isAvailable,
    int? quantity,
    List<String>? images,
    bool? isFavorite,
    double? rating,
    ProductType? type,
    ProductSizeType? sizes,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      off: off ?? this.off,
      about: about ?? this.about,
      isAvailable: isAvailable ?? this.isAvailable,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      sizes: sizes ?? this.sizes
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'name': name});
    result.addAll({'price': price});
    if(off != null){
      result.addAll({'off': off});
    }
    result.addAll({'about': about});
    result.addAll({'sizes': sizes?.toMap()});
    result.addAll({'isAvailable': isAvailable});
    result.addAll({'_quantity': _quantity});
    result.addAll({'images': images});
    result.addAll({'isFavorite': isFavorite});
    result.addAll({'rating': rating});
  
    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
      off: map['off']?.toInt(),
      about: map['about'] ?? '',
      isAvailable: map['isAvailable'] ?? false,
      quantity: map['_quantity']?.toInt() ?? 0,
      type: ProductType.values.firstWhere((e) => e.toString() == map['type']),
      images: List<String>.from(map['images']),
      isFavorite: map['isFavorite'] ?? false,
      rating: map['rating']?.toDouble() ?? 0.0,
      sizes: ProductSizeType.fromMap(map['sizes'])
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(name: $name, price: $price, off: $off, about: $about, isAvailable: $isAvailable, _quantity: $_quantity, images: $images, isFavorite: $isFavorite, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.name == name &&
      other.price == price &&
      other.off == off &&
      other.about == about &&
      other.isAvailable == isAvailable &&
      other._quantity == _quantity &&
      listEquals(other.images, images) &&
      other.isFavorite == isFavorite &&
      other.rating == rating;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      price.hashCode ^
      off.hashCode ^
      about.hashCode ^
      isAvailable.hashCode ^
      _quantity.hashCode ^
      images.hashCode ^
      isFavorite.hashCode ^
      rating.hashCode;
  }
}
