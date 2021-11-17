// lib/main.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:firebase_core/firebase_core.dart";

import "package:hello_world/red_text_widget.dart";

void main() async {
// we intiialize it here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  int _counter = 0;
  String _textValue = "";
  final _key = GlobalKey<FormFieldState<String>>();
  final _formKey = GlobalKey<FormFieldState<String>>();
  final _anotherFormKey = GlobalKey<FormFieldState<String>>();

  // note that this is final - but why and how? unno
  final _controller = TextEditingController.fromValue(
      const TextEditingValue(text: "Initial value"));

  @override
  void initState() {
    // we use this method to setup things
    // not sure if need to call the instance again
    // note the question mark
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    // or, if we have insance defined above, we can just use that to listen
    auth.authStateChanges().listen((user) {
      if (user == null) {
        // i guess signout user }

      } else {
        // i guess signin user - or he is signed in

      }
    });

    // we also need to injitialize the state

    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _signIn() async {
    try {
      // so i guess we get user crednetial
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: "some@email.com", password: "password");

      // the we need to get user? not sure if the same instance can be used, oir we always have to get a new one

      User? user = auth.currentUser;

// here we check some email verification state
// not really sure if this is needed
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    }
    //  this is an interesnting part
    // so we dont really just generally catch
    /* we catch a specific error  */
    on FirebaseAuthException catch (e, stackTrace) {
      if (e.code == "user-not-found") {
        // do somethign if user is not found
      } else if (e.code == "wrong-password") {
        // this is wrong password      //
      }

      // and then there is something called record crash
      _recordCrash(e, stackTrace);
    }
  }

  void _recordCrash(Exception e, StackTrace stackTrace) async {
    // we need to setup firebase foncig
    // but we probably need a plugin for this
    // await FirebaseCrashAnalytics.instance
    //     .recordError(e, stackTrace, reason: "bad times", fatal: true);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const RedTextWidget(
                text:
                    "This is text that is very long now and should fold nicely"),
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MySlideTransition(
                      transitionPage: const AnotherScreen(title: "Go back"),
                    ),
                  );
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
    ));
  }
}

class MySlideTransition extends PageRouteBuilder {
  final Widget transitionPage;

  MySlideTransition({Key? key, required this.transitionPage})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                transitionPage,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child));
}
