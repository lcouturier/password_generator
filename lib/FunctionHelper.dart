import 'package:password_generator/pair.dart';

@deprecated
class FunctionHelper {
  static TResult Function(T) memoize<T, TResult>(
      TResult Function(T) operation) {
    if (operation == null) {
      throw new ArgumentError('operation is null');
    }
    var d = new Map<T, TResult>();
    return (args) {
      if (d.containsKey(args)) {
        return d[args];
      }
      var result = operation(args);
      d[args] = result;
      return result;
    };
  }

  static Pair<Duration, TResult> Function(T) measure<T, TResult>(
      TResult Function(T) operation) {
    if (operation == null) {
      throw new ArgumentError('operation is null');
    }
    return (args) {
      Stopwatch sw = Stopwatch();
      sw.start();
      var result = operation(args);
      sw.stop();

      return Pair.of(sw.elapsed, result);
    };
  }
}
