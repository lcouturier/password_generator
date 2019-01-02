import 'dart:core';
import 'package:flutter/material.dart';
import 'package:password_generator/SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:password_generator/Translations.dart';

void main() {
  runApp(new MaterialApp(
    localizationsDelegates: [   
      const TranslationsDelegate(),  
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''), // English
      const Locale('fr', ''), // French
    ],
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new MyHomePage()
    },
  ));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Translations.of(context).text("app_title"),      
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: Translations.of(context).text("main_title")),
      home: MyHomePage(title: "Password Generator")
    );
  }
}
  
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
 

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  
  void _incrementCounter() {
    setState(() {     
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(        
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(            
            onSelected: choiceAction, 
            itemBuilder: getPopMenuEntry,
          )           
        ],        
      ),
      body: Center(        
        child: Column(          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,      
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }


  void choiceAction(String choice) {
      // TODO : Implémenter le traitement des commandes
      if (choice == "Copy")
      {
        ClipboardManager.copyToClipBoard("Mot de passe généré...");
      }
  }

  PopupMenuItem<String> getPopUpItem(String choice){
    return PopupMenuItem<String>(
      value: choice,
      child: Text(choice)
    );
  }

  List<PopupMenuEntry> getPopMenuEntry(BuildContext context)
  {
    return ItemsPopup.Items.map(getPopUpItem).toList(); 
  }
}



class ItemsPopup {
  static const String Apparence = "Apparence";
  static const String Copy = "Copy";
  static const List<String> Items = <String>[
      Settings,
      Copy, 
      Apparence,
      SignOut
  ];

  static const String Settings = "Settings";
  static const String SignOut = "SignOut";
}
