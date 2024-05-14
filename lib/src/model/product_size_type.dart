import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_commerce_flutter/src/model/categorical.dart';
import 'package:e_commerce_flutter/src/model/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({
    this.numerical,
    this.categorical,
  });

  ProductSizeType copyWith({
    List<Numerical>? numerical,
    List<Categorical>? categorical,
  }) {
    return ProductSizeType(
      numerical: numerical ?? this.numerical,
      categorical: categorical ?? this.categorical,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(numerical != null){
      result.addAll({'numerical': numerical!.map((x) => x?.toMap()).toList()});
    }
    if(categorical != null){
      result.addAll({'categorical': categorical!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory ProductSizeType.fromMap(Map<String, dynamic> map) {
    return ProductSizeType(
      numerical: map['numerical'] != null ? List<Numerical>.from(map['numerical']?.map((x) => Numerical.fromMap(x))) : null,
      categorical: map['categorical'] != null ? List<Categorical>.from(map['categorical']?.map((x) => Categorical.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSizeType.fromJson(String source) => ProductSizeType.fromMap(json.decode(source));

  @override
  String toString() => 'ProductSizeType(numerical: $numerical, categorical: $categorical)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductSizeType &&
      listEquals(other.numerical, numerical) &&
      listEquals(other.categorical, categorical);
  }

  @override
  int get hashCode => numerical.hashCode ^ categorical.hashCode;
}
