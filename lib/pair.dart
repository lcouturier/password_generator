class Pair<T1,T2> {
  const Pair(this.item1, this.item2);

  factory Pair.fromList(List items) {
    if (items.length != 2) {
      throw new ArgumentError('items must have length 2');
    }

    return new Pair<T1, T2>(items[0] as T1, items[1] as T2);
  }

  factory Pair.of(T1 v1, T2 v2) {    
    return new Pair<T1, T2>(v1, v2);
  }

  final T1 item1;
  final T2 item2;

  @override
  bool operator ==(o) => o is Pair && o.item1 == item1 && o.item2 == item2;    

  @override
  String toString() => '[$item1, $item2]';

  Pair<T1, T2> withItem1(T1 v) {
    return new Pair<T1, T2>(v, item2);
  }


  Pair<T1, T2> withItem2(T2 v) {
    return new Pair<T1, T2>(item1, v);
  }

  List toList({bool growable: false}) => new List.from([item1, item2], growable: growable);
}


