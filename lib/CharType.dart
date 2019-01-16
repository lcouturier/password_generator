class CharType {
  static final CharType none = CharType(0, "None");

  static final CharType accentuated = CharType(16, "accentuated");
  static final CharType brackets = CharType(64, "brackets");
  static final CharType lower = CharType(1, "Lower");
  static final CharType minus = CharType(128, "minus");
  static final CharType number = CharType(4, "Number");
  static final CharType punctuation = CharType(32, "punctuation");
  static final CharType space = CharType(512, "space");
  static final CharType special = CharType(8, "Special");
  static final CharType underline = CharType(256, "underline");
  static final CharType upper = CharType(2, "Upper");

  final int code;
  final String label;

  @override
  bool operator &(o) => o is CharType && (this.code & o.code) == o.code;

  @override
  CharType operator |(CharType o) => CharType(this.code | o.code, "***");

  @override
  bool operator ==(o) => o is CharType && o.code == this.code;

  @override
  String toString() => "$code $label";

  const CharType(this.code, this.label);
}

/*
Liste des types de caractères
*/
List<CharType> charTypes() => [
      CharType.accentuated,
      CharType.brackets,
      CharType.lower,
      CharType.minus,
      CharType.number,
      CharType.punctuation,
      CharType.space,
      CharType.special,
      CharType.underline,
      CharType.upper
    ];
