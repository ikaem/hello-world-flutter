import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _textValue = "";
  final _key = GlobalKey<FormFieldState<String>>();

  // note that this is final - but why and how? unno
  final _controller = TextEditingController.fromValue(
      const TextEditingValue(text: "Initial value"));

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
    print(_controller.text);

    print("no way ${_key.currentState?.value}");

    _controller.addListener(() {
      setState(() {
        _textValue = _controller.text;
      });
    });

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
            TextFormField(
              key: _key,
            ),

            const Text(
              'You :',
            ),
            TextField(
              controller: _controller,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [Text("Joe"), Text("What"), Text("What")],
            // ),
            // Stack(
            //   children: const [
            //     Text("what"),
            //     Text("what"),
            //     Text("what"),
            //   ],
            // ),
            ElevatedButton(
                onPressed: () {
                  print("Hello printer");
                },
                child: const Text("hello")),

            Container(
              decoration:
                  BoxDecoration(border: Border.all(), color: Colors.yellow),
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.all(14),
              child: const Text("Lovely insets"),
            ),

            // const Text(
            //   "Some more text",
            //   style: TextStyle(color: Colors.red, fontSize: 14),
            //   textAlign: TextAlign.center,
            // ),
            // Image.asset("images/logo.png"),
            // const Image(image: AssetImage("images/logo.png")),
            // const Image(
            //     image: NetworkImage(
            //         "https://i.pinimg.com/564x/e8/9e/94/e89e94a6ed5075c7c3acfa09390c8690.jpg")),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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

// this is an example

// WeatherService.onForecastChange().listen((Forecast fct) {
//   if(fct.sunny) {
//     print("Sunny");
//   } else {
//     print("Not sunny");
//   }
// })

class TapExample extends StatefulWidget {
  // this now i guess is a constructor
  TapExample({Key? key}) : super(key: key);

  @override
  _TapExampleState createState() => _TapExampleState();
}

class _TapExampleState extends State<TapExample> {
  int _counter = 0;

  // adding more states
  bool _dragging = false;
  Offset _move = Offset.zero;
  int _dragCount = 0;

  // more states
  double _scale = 1.0;
  bool _resizing = true;
  int _scaleCount = 0;

  @override
  void initState() {
    super.initState();
    // and then we can add some other custom initialiation here
    // maybe we initialize a database connection
  }

  @override
  void dispose() {
    // some other custom cleanup code
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap: () {
        // onDoubleTap: () {
        // onLongPress: () {
        //   setState(() {
        //     // ok, so here we are using this set state
        //     // we could have easily created a function of its own
        //     _counter++;
        //   });

// note that we do get some detials about draginng here
        // onHorizontalDragStart: (DragStartDetails details) {
        //   setState(() {
        //     _move = Offset.zero;
        //     _dragging = true;
        //   });
        // },
        // onHorizontalDragUpdate: (DragUpdateDetails details) {
        //   setState(() {
        //     _move += details.delta;
        //   });
        // },
        // onHorizontalDragEnd: (DragEndDetails details) {
        //   setState(() {
        //     _dragging = false;
        //     _dragCount++;
        //   });
        // },

        onScaleStart: (ScaleStartDetails details) {
          // this is avaialable by magic to us - we get it from the stateful widget
          if (mounted) {
            setState(() {
              _scale = 1.0;
            });
          }
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _scale = details.scale;
          });
        },
        onScaleEnd: (ScaleEndDetails details) {
          setState(() {
            _resizing = false;
            _scaleCount++;
          });
        },
        child:
            Container(color: Colors.grey, child: Text("Tap count: $_counter")));
  }
}
