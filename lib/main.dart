import 'dart:core';
import 'package:flutter/material.dart';
import 'package:password_generator/CharType.dart';
import 'package:password_generator/Password.dart';
import 'package:password_generator/SharedPreferencesHelper.dart';
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
      '/HomeScreen': (BuildContext context) =>
          new MyHomePage(title: "Générateur de mot de passe")
    },
  ));
}

@Deprecated('Old App')
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Translations.of(context).text("app_title"),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: Translations.of(context).text("main_title")));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _size = 8;
  bool _lower = false;
  bool _upper = false;
  bool _number = false;
  String _password = "";
  double _sliderValue = 10.0;

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  void _setSize(double value) {
    setState(() {
      _size = value.toInt();
    });
  }

  void _generatePassword() {
    setState(() {
      CharType value = CharType.none;
      if (_lower) {
        value |= CharType.lower;
      }
      if (_upper) {
        value |= CharType.upper;
      }
      if (_number) {
        value |= CharType.number;
      }
      _password = Password.of(_size, value);
    });
  }

  Widget get submitRatingButton {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: _generatePassword,
            child: Text('Genérer'),
            color: Colors.blue,
          ),
        ]);
  }

  Widget get addColumns {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Minuscules", textAlign: TextAlign.center),
            Switch(
              value: _lower,
              key: Key("lowerSwitch"),
              onChanged: (bool value) {
                _lower = value;
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Majuscules", textAlign: TextAlign.left),
            Switch(
              value: _upper,
              onChanged: (bool value) {
                _upper = value;
              },
              key: Key("upperSwitch"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Nombres", textAlign: TextAlign.left),
            Switch(
              value: _number,
              onChanged: (bool value) {
                _number = value;
              },
              key: Key("numberSwitch"),
            ),
          ],
        ),
        Text(
          '$_password',
          style: Theme.of(context).textTheme.display1,
        )
      ],
    );
  }

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 32.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 4.0,
                  max: 32.0,
                  onChanged: _setSize,
                  value: _size.toDouble(),
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text('${_size}',
                    style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get addSwitch {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Switch(
                value: _lower,
                key: Key("lowerSwitch"),
                onChanged: (bool value) {
                  _lower = value;
                },
              ),
              Container(
                width: 150.0,
                alignment: Alignment.centerLeft,
                child: Text('Minuscules'),
              ),
            ],
          ),
        ),
      ],
    );
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
      body: ListView(
        children: <Widget>[
          addYourRating,
          addSwitch,
          addColumns,
          submitRatingButton
        ],
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: _generatePassword,
        tooltip: 'Génération du mot de passe',
        child: Icon(Icons.done),
      ),
      */
    );
  }

  void choiceAction(String choice) {
    if (choice == "Copy") {
      ClipboardManager.copyToClipBoard(_password);
    }
    if (choice == "Clear") {
      ClipboardManager.copyToClipBoard("");
    }
    if (choice == "Reinit") {
      Preferences.clearAll();
    }
    if (choice == "Save") {
      _saveOptions();
    }
  }

  void _loadOptions() {}

  void _saveOptions() {
    Preferences.setBool("Lower", _lower);
    Preferences.setBool("Upper", _upper);
    Preferences.setBool("Number", _number);
    Preferences.setValue("Size", _size.toInt().toString());
  }

  PopupMenuItem<String> getPopUpItem(String choice) {
    return PopupMenuItem<String>(value: choice, child: Text(choice));
  }

  List<PopupMenuEntry<String>> getPopMenuEntry(BuildContext context) {
    return ItemsPopup.Items.map(getPopUpItem).toList();
  }
}

class ItemsPopup {
  static const String Apparence = "Apparence";
  static const String Copy = "Copy";
  static const String Clear = "Clear";
  static const List<String> Items = <String>[
    Settings,
    Copy,
    Clear,
    Apparence,
    Save
  ];

  static const String Save = "Save";
  static const String Settings = "Settings";
}
