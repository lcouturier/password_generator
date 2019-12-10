class Options {
  int size;
  bool lower;
  bool upper;
  bool number;
  bool specials;
  bool punctuations;

  Options(this.size, this.lower, this.upper, this.number, this.specials, this.punctuations);

  Options.fromJson(Map<String, dynamic> json) {
      size = json['size'] ?? 8;
      lower = json['lower'] ?? false;
      upper = json['upper'] ?? false;
      number = json['number'] ?? false;
      specials = json['specials'] ?? false;
      punctuations = json['punctuations'] ?? false;
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['lower'] = this.lower;
    data['upper'] = this.upper;
    data['number'] = this.number;
    data['special'] = this.specials;
    data['punctuations'] = this.punctuations;
    return data;
  }
}
