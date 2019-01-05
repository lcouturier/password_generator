import 'dart:core';
import 'package:flutter/material.dart';
import 'package:password_generator/CharType.dart';
import 'package:password_generator/Password.dart';
import 'package:password_generator/Preferences.dart';
import 'package:password_generator/SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:password_generator/Translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _specials = false;
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
            textColor: Colors.white,
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

  Widget get addLowerSwitch {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 90.0,
            alignment: Alignment.centerLeft,
            child: Text('Minuscules'),
          ),
          Switch(
            value: _lower,
            key: Key("lowerSwitch"),
            onChanged: (bool value) {
              _lower = value;
            },
          ),
          Container(width: 30),
          Container(
            width: 90.0,
            alignment: Alignment.centerLeft,
            child: Text('Speciaux'),
          ),
          Switch(
            value: _specials,
            key: Key("specialsSwitch"),
            onChanged: (bool value) {
              _specials = value;
            },
          ),
        ],
      ),
    );
  }

  Widget get addUpperSwitch {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           Container(
            width: 90.0,
            alignment: Alignment.centerLeft,
            child: Text('Majuscules'),
          ),
          Switch(
            value: _upper,
            key: Key("upperSwitch"),
            onChanged: (bool value) {
              _upper = value;
            },
          ),
         
        ],
      ),
    );
  }

  Widget get addNumberSwitch {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 90.0,
            alignment: Alignment.centerLeft,
            child: Text('Nombres'),
          ),
          Switch(
            value: _number,
            key: Key("numberSwitch"),
            onChanged: (bool value) {
              _number = value;
            },
          ),
          
        ],
      ),
    );
  }

  Widget get addAllSwitch {
    return Column(
      children: <Widget>[addLowerSwitch, addUpperSwitch, addNumberSwitch],
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
          addSlider,
          VerticalDivider(),
          addAllSwitch,
          VerticalDivider(),
          addGeneratePassword,
          VerticalDivider(color: Colors.white10, height: 100),
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

  void _loadOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _size = prefs.getInt("Size") ?? 8;
      _lower = prefs.getBool("Lower") ?? false;
      _upper = prefs.getBool("Upper") ?? false;
      _number = prefs.getBool("Number") ?? false;
      _specials = prefs.getBool("Specials") ?? false;
    }); 
  }

  void _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Lower", _lower);
    prefs.setBool("Upper", _upper);
    prefs.setBool("Number", _number);
    prefs.setInt("Size", _size.toInt());
    prefs.setBool("Specials", _specials);    
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
