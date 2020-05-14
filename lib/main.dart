import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    _bookNavigatorKey,
    _coffeeNavigatorKey,
  ];

  Future<bool> _systemBackButtonPressed() {
    if (_navigatorKeys[_selectedIndex].currentState.canPop()) {
      _navigatorKeys[_selectedIndex]
          .currentState
          .pop(_navigatorKeys[_selectedIndex].currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Text("Book"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.free_breakfast),
                title: Text("Coffee"),
              )
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            }),
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              BookNavigator(),
              CoffeeNavigator(),
            ],
          ),
        ),
      ),
    );
  }
}

class BookNavigator extends StatefulWidget {
  @override
  _BookNavigatorState createState() => _BookNavigatorState();
}

GlobalKey<NavigatorState> _bookNavigatorKey = GlobalKey<NavigatorState>();

class _BookNavigatorState extends State<BookNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _bookNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return Books1();
                case '/books2':
                  return Books2();
              }
            });
      },
    );
  }
}

class Books1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Books 1"),
        ),
        FlatButton(
          child: Text("Go to books 2"),
          onPressed: () => Navigator.pushNamed(context, '/books2'),
        ),
      ],
    );
  }
}

class Books2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Books 2"),
        )
      ],
    );
  }
}

class CoffeeNavigator extends StatefulWidget {
  @override
  _CoffeeNavigatorState createState() => _CoffeeNavigatorState();
}

GlobalKey<NavigatorState> _coffeeNavigatorKey = GlobalKey<NavigatorState>();

class _CoffeeNavigatorState extends State<CoffeeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _coffeeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return Coffee1();
                case '/coffee2':
                  return Coffee2();
              }
            });
      },
    );
  }
}

class Coffee1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Coffee 1"),
        ),
        FlatButton(
          child: Text("Go to coffee 2"),
          onPressed: () => Navigator.pushNamed(context, '/coffee2'),
        ),
      ],
    );
  }
}

class Coffee2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Coffee 2"),
        ),
      ],
    );
  }
}
