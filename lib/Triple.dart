import 'package:password_generator/pair.dart';

class Triple<T1, T2, T3> extends Pair<T1, T2> {
  const Triple(item1, item2, this.item3) : super(item1, item2);

  factory Triple.fromList(List items) {
    if (items.length != 3) {
      throw new ArgumentError('items must have length 2');
    }

    return new Triple<T1, T2, T3>(
        items[0] as T1, items[1] as T2, items[2] as T3);
  }

  factory Triple.of(T1 v1, T2 v2, T3 v3) {
    return new Triple<T1, T2, T3>(v1, v2, v3);
  }

  final T3 item3;

  @override
  bool operator ==(o) =>
      o is Triple && o.item1 == item1 && o.item2 == item2 && o.item3 == item3;

  @override
  String toString() => '[$item1, $item2, $item3]';

  Triple<T1, T2, T3> withItem1(T1 v) {
    return new Triple<T1, T2, T3>(v, item2, item3);
  }

  Triple<T1, T2, T3> withItem2(T2 v) {
    return new Triple<T1, T2, T3>(item1, v, item3);
  }

  Triple<T1, T2, T3> withItem3(T3 v) {
    return new Triple<T1, T2, T3>(item1, item2, v);
  }

  List toList({bool growable: false}) =>
      new List.from([item1, item2, item3], growable: growable);
}
