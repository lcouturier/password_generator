import 'dart:core';
import 'package:flutter/material.dart';
import 'package:password_generator/CharType.dart';
import 'package:password_generator/Password.dart';
import 'package:password_generator/Preferences.dart';
import 'package:password_generator/SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:password_generator/Toast.dart';
import 'package:password_generator/Translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    MyHomePage.tag: (context) => MyHomePage()
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
          'HomePage': (BuildContext context) =>
              new MyHomePage(title: "Générateur de mot de passe")
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  static final String tag = "HomePage";
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _size = 8;
  bool _lower = false;
  bool _upper = false;
  bool _number = false;
  bool _specials = false;
  bool _punctuations = false;
  String _password = "";

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
      if (_specials) {
        value |= CharType.special;
      }
      if (_punctuations) {
        value |= CharType.punctuation;
      }
      _password = Password.of(_size, value);
    });
  }

  Widget get submitRatingButton {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            onPressed: _generatePassword,
            child: Text('Genérer'),
            textColor: Colors.white,
            color: Colors.blue,
          ),
        ]);
  }

  Widget get addGeneratePassword {
    return Column(children: <Widget>[
      Text(
        '$_password',
        style: Theme.of(context).textTheme.display1,
      )
    ]);
  }

  Widget get addSlider {
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

  Widget createSwitch(
      String label, bool initialValue, void Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150.0,
            alignment: Alignment.centerLeft,
            child: Text(label),
          ),
          Container(
            width: 170.0,
            alignment: Alignment.centerRight,
            child: Switch(
              value: initialValue,
              key: Key(label),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget get addAllSwitch {
    return Column(
      children: <Widget>[
        createSwitch("Minuscules", _lower, (x) => _lower = x),
        createSwitch("Majuscules", _upper, (x) => _upper = x),
        createSwitch("Nombres", _number, (x) => _number = x),
        createSwitch("Caractères spéciaux", _specials, (x) => _specials = x)
        /*
        createSwitch("Ponctuations", _punctuations, (x) => _punctuations = x),
        createSwitch("Minus", _punctuations, (x) => _punctuations = x),
        createSwitch("Underline", _punctuations, (x) => _punctuations = x),
        createSwitch("Espace", _punctuations, (x) => _punctuations = x),
        */
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
      body: Column(children: <Widget>[
        addSlider,
        SizedBox(height: 10),
        VerticalDivider(height: 2),
        addAllSwitch,
        VerticalDivider(height: 2),
        addGeneratePassword,
        SizedBox(height: 20),
        submitRatingButton,
        Expanded(child: Container(height: 5)),
      ]),
    );
  }

  void choiceAction(String choice) {
    if (choice == "Copy") {
      ClipboardManager.copyToClipBoard(_password);
      Message.Show("Copie dans le presse papier");
    }
    if (choice == "Clear") {
      ClipboardManager.copyToClipBoard("");
      Message.Show("Remise à zéro du presse papier");
    }
    if (choice == "Reinit") {
      Preferences.clearAll();
      Message.Show("Suppression des préférences");
    }
    if (choice == "Save") {
      _saveOptions();
      Message.Show("Les options ont été sauvegardées");
    }
  }

  void _loadOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _size = prefs.getInt("Size") ?? 8;
      _lower = prefs.getBool("Lower") ?? false;
      _upper = prefs.getBool("Upper") ?? false;
      _number = prefs.getBool("Number") ?? false;
      _specials = prefs.getBool("Specials") ?? false;
      _punctuations = prefs.getBool("Punctuations") ?? false;
    });
  }

  void _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Lower", _lower);
    prefs.setBool("Upper", _upper);
    prefs.setBool("Number", _number);
    prefs.setInt("Size", _size.toInt());
    prefs.setBool("Specials", _specials);
    prefs.setBool("Punctuations", _punctuations);
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
  static const String Save = "Save";
  static const String Settings = "Settings";

  static const List<String> Items = <String>[
    Settings,
    Copy,
    Clear,
    Apparence,
    Save
  ];
}

class VerticalDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  VerticalDivider(
      {this.height = 1.0, this.width = 1.0, this.color = Colors.black12});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.height,
      width: this.width,
      color: this.color,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
    );
  }
}
