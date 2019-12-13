

import 'dart:math';

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

extension IntExtensions on int {
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);

  int Function() into(int Function(int) operation) {
    return () => operation(this);
  }
}

extension FunctionExtensions on int Function() {
  int Function() into(int Function(int) operation) {
    return () => operation(this());
  }
}


List<T> Function(List<T>) _internalShuffleCore<T>() {
  var random = new Random();
  return (args) {
    for (int x = 0; x < 100; x++) {
      for (int i = args.length; i > 1; i--) {
        int j = random.nextInt(i);
        T tmp = args[j];
        args[j] = args[i - 1];
        args[i - 1] = tmp;
      }
    }
    return args;
  };
}