import 'package:password_generator/pair.dart';

extension FuncExtensions<T, TResult> on TResult Function(T) {
  TResult Function(T) memoize() {
    var d = new Map<T, TResult>();
    return (args) {
      if (d.containsKey(args)) {
        return d[args];
      }
      var result = this(args);
      d[args] = result;
      return result;
    };
  }

  Pair<Duration, TResult> Function(T) measure() {
    return (args) {
      Stopwatch sw = Stopwatch();
      sw.start();
      var result = this(args);
      sw.stop();

      return Pair.of(sw.elapsed, result);
    };
  }

  /*
  Add exception manager to the function
   */
  TResult Function(T) catchError(TResult Function() operation) {
    return (args) {
      try {
        return this(args);
      } catch (e) {
        return operation();
      }
    };
  }
}


extension ListExtensions<T extends num> on List<T> {
  T get sum => this.fold(0 as T, (x, y) => x + y);
}


extension StringExtensions on String {
  String get firsLetterToUpperCase => this[0].toUpperCase() + this.substring(1);
}


extension IntExtensions on int {
  Duration get seconds => Duration(seconds: this);

  Duration get minutes => Duration(minutes: this);

  Duration get hours => Duration(hours: this);

  Duration get days => Duration(days: this);

  int Function() into(int Function(int) operation) {
    return () => operation(this);
  }
}

extension FunctionExtensions on Function() {
  int Function() into(int Function(int) operation) {
    return () => operation(this());
  }
}

extension CurryExtensions<F, S, R> on R Function(F, S) {
  R Function(S) curry(F first) {
    return (S second) => this(first, second);
  }
}
