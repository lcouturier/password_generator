// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_generator/ArrayHelper.dart';
import 'package:password_generator/Password.dart';
import 'package:password_generator/Sequence.dart';
import 'package:password_generator/Triple.dart';
import 'package:password_generator/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Shuffle test', (WidgetTester tester) async {
    var items = [0,1,2,3,4];
    
    var result = ArrayHelper.shuffleInt(items);
    print(result.map((x) => x.toString()).reduce((a, b) => "$a$b"));    


    for (var item in ArrayHelper.cycle(items).take(20)) {
        print(item);
    } 
  });

  testWidgets('Sequence test 1', (WidgetTester tester) async {

      var result = Sequence.generate(1, (x) => x + 1).take(20).map((x) => x.toString()).reduce((a, b) => "$a$b");    
      print(result);
  });

  testWidgets('Sequence factorial 1', (WidgetTester tester) async {

      var result = Sequence.factorial.take(10).map((x) => x.toString()).reduce((a, b) => "$a, $b");    
      print(result);
  });

  testWidgets('Sequence fibonacci 1', (WidgetTester tester) async {

      var result = Sequence.fibonacci.take(20).map((x) => x.toString()).reduce((a, b) => "$a, $b");    
      print(result);
  });


  testWidgets('Password test', (WidgetTester tester) async {
      for (int x = 0; x < 10; x++)            
      {
        var result = await Password.of(16, CharType.lower);    
        print(result);
      }      
  });


  testWidgets('Triple Test', (WidgetTester tester) async {
      var t = Triple.of(1,2,3);
      var t2 = t.withItem2(4);
      
      expect(t2.item2, 4);    
  });
}
