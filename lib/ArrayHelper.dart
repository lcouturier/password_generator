import 'dart:math';

class ArrayHelper {
  static var shuffleInt = ArrayHelper._internalShuffleCore<int>();
  static var shuffleString = ArrayHelper._internalShuffleCore<String>();

  static List<String> shuffle(String value) =>
      shuffleString(ArrayHelper.toIterable(value).toList());

  static List<T> Function(List<T>) _internalShuffleCore<T>() {
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

  static Iterable<String> toIterable(String value) sync* {
    for (int i = 0; i < value.length; i++) {
      yield value[i];
    }
  }

  static Iterable<int> cycle(Iterable<int> items) sync* {
    while (true) {
      for (int item in items) {
        yield item;
      }
    }
  }
}
