

import 'ArrayHelper.dart';

class CharType {
    final int code;
    final String label;    
  
    static final CharType none = CharType(0,"None");
    static final CharType lower = CharType(1,"Lower");
    static final CharType upper = CharType(2,"Upper");
    static final CharType number = CharType(4,"Number");
    static final CharType special = CharType(8,"Special");
    static final CharType accentuated = CharType(16,"accentuated");
    static final CharType punctuation = CharType(32,"punctuation");
    static final CharType brackets = CharType(64,"brackets");
    static final CharType minus = CharType(128,"minus");
    static final CharType underline = CharType(256,"underline");
    static final CharType space = CharType(512,"space");
    
    const CharType(this.code, this.label)

    @override
    bool operator ==(o) => o is CharType && o.code == this.code;    

    @override
    bool operator &(o) => o is CharType && (this.code & o.code) == this.code;    

    /*
    static const Upper = 2;
    static const Number = 4;
    static const Special = 8;        
    static const Accentuated = 16;        
    static const Punctuation = 32;        
    static const Brackets = 64;        
    static const Minus = 128;        
    static const Underline = 256;        
    static const Space = 512;        
    */

    // static const All = Lower  | Upper | Number | Special | Accentuated | Punctuation | Brackets | Minus | Underline | Space;        
}

class Password {
  static const lower = 'abcdefghijklmnopqrstuvwxyz';
  static const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const numbers = '012345678901234567890123456789';
  static const specials = '@#&"§%£=+*/';
  static const accentuated = 'éèà';  
  static const punctuation = ',.;:?!';
  static const brackets = '()[]{}<>';
  static const minus = '-';
  static const underline = '_';
  static const space = ' ';

 
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