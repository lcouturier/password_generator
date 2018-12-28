

import 'package:password_generator/CharType.dart';

import 'ArrayHelper.dart';

class Password {
  static const accentuated = 'éèà';  
  static const brackets = '()[]{}<>';
  static const lower = 'abcdefghijklmnopqrstuvwxyz';
  static const minus = '-';
  static const numbers = '012345678901234567890123456789';
  static const punctuation = ',.;:?!';
  static const space = ' ';
  static const specials = '@#&"§%£=+*/';
  static const underline = '_';
  static const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  static String _getAll(List<String> items) {      
      var all = items.reduce((a, b) => "$a$b");
      return ArrayHelper.shuffle(all).reduce((a, b) => "$a$b");
    }

  static Future<String> of(int size, CharType value) async {                  
      var items = new List<String>();
      if (value & CharType.lower) {
          items.add(lower);
      }
      if (value & CharType.upper) {
          items.add(upper);
      }
      if (value & CharType.number) {
          items.add(numbers);
      }
      if (value & CharType.special) {
          items.add(specials);
      }
                  
      var sb = new StringBuffer();
      for (int x = 0; x < 10; x++)            
      {        
        sb.write(_getAll(items));          
      }

      return ArrayHelper.shuffle(sb.toString()).take(size).reduce((a, b) => "$a$b");      
  }
}