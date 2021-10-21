import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:get/get.dart';

void main() {
  runApp(const FometicApp());
}

class FometicApp extends StatelessWidget {
  const FometicApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fometic Mobile',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const FometicHomePage(title: 'Fometic Mobile Home Page'),
    );
  }
}

class FometicHomePage extends StatefulWidget {
  const FometicHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<FometicHomePage> createState() => _FometicHomePageState();
}

class _FometicHomePageState extends State<FometicHomePage> {
  int _counter = 0;
  double _degrees = 0.0;
  double _distance = 0.0;
  String _pad = "";

  double _validateDegrees (double degrees) {
    double valid_degrees = 0.0;
    if ( degrees >= 0.0 && degrees < 20.0 ) {
      valid_degrees = 0.0;
    } else if ( degrees >= 20.0 && degrees < 60.0 ){
      valid_degrees = 45.0;
    } else if ( degrees >= 60.0 && degrees < 120.0 ) {
      valid_degrees = 90.0;
    } else if ( degrees >= 120.0 && degrees < 150.0 ){
      valid_degrees = 135.0;
    } else if ( degrees >= 150.0 && degrees < 210.0 ){
      valid_degrees = 180.0;
    } else if ( degrees >= 210.0 && degrees < 230.0 ){
      valid_degrees = 225.0;
    } else if ( degrees >= 230.0 && degrees < 290.0 ){
      valid_degrees = 270.0;
    } else if ( degrees >= 290.0 && degrees < 330.0 ){
      valid_degrees = 315.0;
    } else if ( degrees >= 330.0 && degrees < 360.0 ){
      valid_degrees = 0.0;
    }
    return valid_degrees;
  }
  void _padACallback(double degrees, double distanceFromCenter) {
      _degrees = _validateDegrees(degrees);

      _distance = distanceFromCenter;
      _pad = "A";
      print("pad:"+_pad +" degrees: "+ _degrees.toString()+" distance:"+_distance.toString());
  }
  void _padBCallback(double degrees, double distanceFromCenter) {
    _degrees = _validateDegrees(degrees);
    _distance = distanceFromCenter;
    _pad = "B";
    print("pad:"+_pad +" degrees: "+ _degrees.toString()+" distance:"+_distance.toString());
  }
  void _padCCallback(double degrees, double distanceFromCenter) {
    _degrees = _validateDegrees(degrees);
    _distance = distanceFromCenter;
    _pad = "C";
    print("pad:"+_pad +" degrees: "+ _degrees.toString()+" distance:"+_distance.toString());
  }

  void _padDCallback(double degrees, double distanceFromCenter) {
    _degrees = _validateDegrees(degrees);
    _distance = distanceFromCenter;
    _pad = "D";
    print("pad:"+_pad +" degrees: "+ _degrees.toString()+" distance:"+_distance.toString());
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'You have moved PAD :',
            ),
            Text(
              '$_pad',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Degree / Distance :',
            ),
            Text(
              '$_degrees  $_distance',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              children: <Widget>[
                JoystickView(
                  iconsColor: Colors.deepOrange,
                  backgroundColor: Colors.amber,
                  innerCircleColor: Colors.blue,
                  opacity: 0.8,
                  size: 170.0,
                  interval: const Duration(milliseconds : 500),
                  onDirectionChanged: _padACallback,
                ),
                JoystickView(
                  size: 170.0,
                  interval: const Duration(milliseconds : 500),
                  onDirectionChanged: _padBCallback,
                ),

              ],
            ),
            Row(
              children: <Widget>[
                JoystickView(
                  size: 170.0,
                  interval: const Duration(milliseconds : 500),
                  onDirectionChanged: _padCCallback,
                ),
                JoystickView(
                  size: 170.0,
                  interval: const Duration(milliseconds : 500),
                  onDirectionChanged: _padDCallback,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
