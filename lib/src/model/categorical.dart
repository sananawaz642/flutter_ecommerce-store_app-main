import 'dart:convert';

enum CategoricalType { small, medium, large }

class Categorical {
  CategoricalType categorical;
  bool isSelected = false;

  Categorical(
    this.categorical,
    this.isSelected,
  );


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'categorical': categorical.toString()});
    result.addAll({'isSelected': isSelected});
  
    return result;
  }

  factory Categorical.fromMap(Map<String, dynamic> map) {
    return Categorical(
      CategoricalType.values.firstWhere((element) => element.toString()==map['categorical']),
      map['isSelected'] ?? false,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Categorical.fromJson(String source) => Categorical.fromMap(json.decode(source));

  @override
  String toString() => 'Categorical(isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Categorical &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode => isSelected.hashCode;
}
