import 'dart:convert';

class Numerical {
  String numerical;
  bool isSelected = false;

  Numerical(
    this.numerical,
    this.isSelected,
  );

  Numerical copyWith({
    String? numerical,
    bool? isSelected,
  }) {
    return Numerical(
      numerical ?? this.numerical,
      isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'numerical': numerical});
    result.addAll({'isSelected': isSelected});
  
    return result;
  }

  factory Numerical.fromMap(Map<String, dynamic> map) {
    return Numerical(
      map['numerical'] ?? '',
      map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Numerical.fromJson(String source) => Numerical.fromMap(json.decode(source));

  @override
  String toString() => 'Numerical(numerical: $numerical, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Numerical &&
      other.numerical == numerical &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode => numerical.hashCode ^ isSelected.hashCode;
}
