import 'dart:convert';

class Options {
  final int size;
  final bool lower;
  final bool upper;
  final bool number;
  final bool specials;
  final bool punctuations;
  Options({
    this.size,
    this.lower,
    this.upper,
    this.number,
    this.specials,
    this.punctuations,
  });

  Options copyWith({
    int size,
    bool lower,
    bool upper,
    bool number,
    bool specials,
    bool punctuations,
  }) {
    return Options(
      size: size ?? this.size,
      lower: lower ?? this.lower,
      upper: upper ?? this.upper,
      number: number ?? this.number,
      specials: specials ?? this.specials,
      punctuations: punctuations ?? this.punctuations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'lower': lower,
      'upper': upper,
      'number': number,
      'specials': specials,
      'punctuations': punctuations,
    };
  }

  static Options fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Options(
      size: map['size'],
      lower: map['lower'],
      upper: map['upper'],
      number: map['number'],
      specials: map['specials'],
      punctuations: map['punctuations'],
    );
  }

  String toJson() => json.encode(toMap());

  static Options fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Options size: $size, lower: $lower, upper: $upper, number: $number, specials: $specials, punctuations: $punctuations';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Options &&
      o.size == size &&
      o.lower == lower &&
      o.upper == upper &&
      o.number == number &&
      o.specials == specials &&
      o.punctuations == punctuations;
  }

  @override
  int get hashCode {
    return size.hashCode ^
      lower.hashCode ^
      upper.hashCode ^
      number.hashCode ^
      specials.hashCode ^
      punctuations.hashCode;
  }
} 