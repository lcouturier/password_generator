


import 'package:password_generator/pair.dart';

class MatchNotFoundException implements Exception {
  final String cause;
  MatchNotFoundException(this.cause);
}

extension PatternMatchExtensions on Object {
  PatternMatchContext match() {
    return PatternMatchContext(this);
  }
}

class PatternMatchContext<T, R> {
  final T value;

  PatternMatchContext(this.value);

  PatternMatch<T, R> with(bool Function(T) condition, R Function(T) result) {
    var p = PatternMatch(this.value);
    return p.
  }
}


class PatternMatch<T,R>{
  T value;
  List<Pair<bool Function(T), R Function(T)>> cases = List<Pair<bool Function(T), R Function(T)>>();

  PatternMatch(this.value)

  PatternMatch with(bool Function(T) condition, R Function(T) result) {
    return PatternMatch(this.value, cases + [Pair.of(condition, result)]);
  }

  PatternMatch otherwise(R Function(T) result) {
    var item = List<Pair<bool Function(T), R Function(T)>>();
    item.add(Pair.of((x) => true, result));

    return PatternMatch(this.value, cases + item);
  }

  R exec()  { 
    var notFound = (!cases.any((x) => x.item1(this.value)); 
    if (!notFound) throw new MatchNotFoundException("Incomplete pattern match");

    var f = cases.firstWhere((x) => x.item1(this.value)).item2;
    return f(this.value); 
  }
}