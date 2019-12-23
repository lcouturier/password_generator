

class MatchNotFoundException implements Exception {
  final String cause;
  MatchNotFoundException(this.cause);
}

extension PatternMatchExtensions<T> on T {
  PatternMatchContext match() {
    return PatternMatchContext(this);
  }
}

class PatternMatchContext<T, R> {
  final T value;

  const PatternMatchContext(this.value);

  PatternMatch<T, R> check(bool Function(T) condition, R Function(T) result) {
    return PatternMatch<T, R>(this.value, List<PatternFunc<T,R>>());
  }
}

class PatternFunc<T,R> {
  final bool Function(T) predicate;
  final R Function(T) map;

  const PatternFunc(this.predicate, this.map);
}

class PatternMatch<T,R>{
  final T value;
  final List<PatternFunc<T,R>> cases;

  const PatternMatch(this.value, this.cases);

  PatternMatch<T, R> check(bool Function(T) condition, R Function(T) result) {
    return PatternMatch<T,R>(this.value, cases + [PatternFunc(condition, result)]);
  }

  PatternMatch<T,R> otherwise(R Function(T) result) {
    var item = List<PatternFunc<T, R>>();
    item.add(PatternFunc((x) => true, result));

    return PatternMatch<T, R>(this.value, cases + item);
  }

  R exec() {
    var notFound = (!cases.any((x) => x.predicate(this.value)));
    if (!notFound) throw new MatchNotFoundException("Incomplete pattern match");

    var f = cases.firstWhere((x) => x.predicate(this.value)).map;
    return f(this.value);
  }
}


