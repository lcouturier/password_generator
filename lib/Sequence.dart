import 'package:password_generator/pair.dart';

class Sequence 
{  
  static Iterable<int> numbers = generate(0, (x) => x + 1);
  static Iterable<int> even = generate(0, (x) => x + 2);
  static Iterable<int> odd = generate(1, (x) => x + 2);


  static Iterable<int> fibonacci = generate(Pair.of(0,1), (x) => Pair.of(x.item2, x.item2 + x.item1)).map((x) => x.item1);
  static Iterable<int> factorial = generate(Pair.of(1,1), (x) => Pair.of(x.item1 * x.item2, x.item2 + 1)).map((x) => x.item1);

  static Iterable<T> generate<T>(T start, T Function(T) operation) sync* {
      T next = start;
      while(true)
      {
         yield next;
         next = operation(next);         
      }
  }
}
