import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      // dont need it because we have "/"
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // routes: {
      //   "/": (context) => const MyHomePage(title: "Flutter Demo Home Page"),
      //   "/screen2": (context) => const AnotherScreen(title: "Go back")
      // }
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MaterialPageRoute(
              builder: (context) =>
                  const MyHomePage(title: "Flutter Demo Home Page"));
        } else if (settings.name == "/screen2") {
          return MaterialPageRoute<bool>(
              builder: (context) =>
                  AnotherScreen(title: settings.arguments as String));
        }
      },
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
  final _formKey = GlobalKey<FormFieldState<String>>();
  final _anotherFormKey = GlobalKey<FormFieldState<String>>();

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
    print("this is key value: ${_key.currentState?.value}");
    print(
        "this is regualr controller state that will actually be called on its own trigger: ${_controller.text} ");

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
            ElevatedButton(
                onPressed: () async {
                  // i guess this is the top context
                  // this is very cool
                  // the reoute is already prerpared completely in the Material app
                  // Navigator.of(context)
                  //     .pushNamed("/screen2", arguments: "Go back again");

                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AnotherScreen(title: "Go back"),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child;
                      }));

                  // bool? outcome = await Navigator.of(context)
                  //     .pushNamed("/screen2", arguments: "Go back again");

                  // bool? outcome = await Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return const AnotherScreen(title: "Go back");
                  // }));

                  // this is the snackbar
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text("$outcome")),
                  // );

                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return const AnotherScreen(title: "Go back");
                  // }));
                },
                child: const Text("Press this")),
            TextFormField(
              key: _key,
              // no need for type
              validator: (String? value) {
                return value == null || value.isEmpty
                    ? "Please make sure there is no empty value"
                    : null;
              },
              //     validator: (String value) {
              //   return value?.isEmpty ? "Not empty" : null;
              // }
            ),
            Form(
                key: _anotherFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (String? value) {
                        return value == null || value.isEmpty
                            ? "Cannot be empty"
                            : null;
                      },
                    ),
                  ],
                )),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(),
                  TextFormField(),
                  Builder(
                      builder: (BuildContext subcontext) => TextButton(
                          onPressed: () {
                            final valid = Form.of(subcontext)?.validate();
                            print("valid: $valid");
                          },
                          child: const Text("Validate")))
                ],
              ),
            ),
            const Text(
              'You :',
            ),
            TextField(
              controller: _controller,
            ),
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

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(title)),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("false"))
        ],
      ),

      // child: ElevatedButton(
      //   child: Text(title),
      //   onPressed: () {
      //     // Navigator.of(context).pop();
      //     Navigator.pop(context);
      //     // something
      //   },
      // ),
    ));
  }
}
