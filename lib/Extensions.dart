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
