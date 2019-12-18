class Options {
  int size;
  bool lower;
  bool upper;
  bool number;
  bool specials;
  bool punctuations;

  Options(this.size, this.lower, this.upper, this.number, this.specials,
      this.punctuations);

  factory Options.fromJson(Map<String, dynamic> json) {
    var size = json['size'] ?? 8;
    var lower = json['lower'] ?? false;
    var upper = json['upper'] ?? false;
    var number = json['number'] ?? false;
    var specials = json['specials'] ?? false;
    var punctuations = json['punctuations'] ?? false;
    return Options((size), lower, upper, number, specials, punctuations);
  }

  Map<String, dynamic> toJson() {
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
