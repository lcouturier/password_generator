

import 'package:password_generator/CharType.dart';
import 'ArrayHelper.dart';

class Password {
  
  static String Function(int, CharType) _ofCore() {
      Map<CharType,String> d = new Map<CharType,String>();
      d[CharType.accentuated] = accentuated;
      d[CharType.brackets] = brackets;
      d[CharType.lower] = lower;
      d[CharType.minus] = minus;
      d[CharType.number] = numbers;
      d[CharType.punctuation] = punctuation;
      d[CharType.special] = specials;
      d[CharType.underline] = underline;
      d[CharType.upper] = upper;      
      d[CharType.space] = space;

      return (int size, CharType type) {

          var value = charTypes().where((x) => (type & x)).map((x) => d[x]).reduce((a, b) => "$a$b");          
          return ArrayHelper.shuffle(Iterable.generate(10).map((x) => ArrayHelper.shuffle(value).reduce((a, b) => "$a$b")).reduce((a, b) => "$a$b")).take(size).reduce((a, b) => "$a$b");              
      };
  }

  static String Function(int, CharType) get of => _ofCore();


  static const accentuated = 'éèà';  
  static const brackets = '()[]{}<>';
  static const lower = 'abcdefghijklmnopqrstuvwxyz';
  static const minus = '-';
  static const numbers = '0123456789';
  static const punctuation = ',.;:?!';
  static const space = ' ';
  static const specials = '@#&"\'§%£=+*/|';
  static const underline = '_';
  static const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';  
}