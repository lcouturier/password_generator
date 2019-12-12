

import 'package:password_generator/pair.dart';

extension FuncExtensions<T,TResult> on TResult Function(T) {
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