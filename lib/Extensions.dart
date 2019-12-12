

import 'dart:math';

import 'package:password_generator/pair.dart';

import 'ArrayHelper.dart';

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

      10.into().into()

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

extension StringExtensions on String {
  static List<String> shuffle() {
    var f = _internalShuffleCore<String>();
    return f(this)
  }

  static Iterable<String> toIterable() sync* {
    var value = this;
    for (int i = 0; i < value.length; i++) {
      yield value[i];
    }
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