// lib/main.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:google_mobile_ads/google_mobile_ads.dart';

import "package:hello_world/red_text_widget.dart";

void main() async {
// we intiialize it here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// this is just a function
// so we can call our own error logger
// it seems we jsut overrode the default on error
// so now our function will catch the error

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // this is a static field
  // it means it can be called on the class?
  // we dont have to create a n object to access it
  // so we setup analytics
  // then we setup the observer , and we use the analyrics as an argument to Analytics observer
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // here we just include the observer from above
      // we literally attach them
      // and we type the observers
      // i dont even thing we need to type it
      navigatorObservers: <NavigatorObserver>[observer],
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _reference = FirebaseDatabase.instance.reference();

  int _counter = 0;
  RewardedAd? _myRewarded;
  String _textValue = "";
  final _key = GlobalKey<FormFieldState<String>>();
  final _formKey = GlobalKey<FormFieldState<String>>();
  final _anotherFormKey = GlobalKey<FormFieldState<String>>();

  // note that this is final - but why and how? unno
  final _controller = TextEditingController.fromValue(
      const TextEditingValue(text: "Initial value"));

  @override
  void initState() {
    // using navigator observers instead
    // MyApp.observer.analytics.logAppOpen();
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

  void _loadAdvert() async {
    await RewardedAd.load(
        adUnitId: "AdUnitId",
        // this is a widget
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _myRewarded = ad;
            /* we will define this  */
            _listenOnAdvert();
          },
          onAdFailedToLoad: (error) async {
            print("Failed to load ad ${error.message}");
          },
        ));
  }

  void _listenOnAdvert() {
    // note that we have to force if with ! null check
    // full screen content callback also seems to be a widget
    _myRewarded!.fullScreenContentCallback =
        FullScreenContentCallback(onAdShowedFullScreenContent: (RewardedAd ad) {
      print("$ad onAdDismissedFullScreenContent");
    }, onAdDismissedFullScreenContent: (RewardedAd ad) async {
      print("$ad onAdDismissedFullScreenContent");
      await ad.dispose();
    }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) async {
      print("$ad onAdFailedToShowFullScreenContent: $error");
      await ad.dispose();
    });
  }

  void _showAdvert() {
    _myRewarded!.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
      print("$ad onUserEarnedReward $rewardItem");
    });
  }

  void _updateRealtimeDatabase() async {
    // the configuration is above in the class

    _reference.child("messages/a3bj2/deleted").set(true);
  }

  void _updateFirestore() async {
    // we access document
    _firestore.doc("messages/a3bdj2").update({"deleted": true});
  }

  void _signIn() async {
    try {
      // so i guess we get user crednetial
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: "some@email.com", password: "password");

      User? user = auth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e, stackTrace) {
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

    await FirebaseCrashlytics.instance
        .recordError(e, stackTrace, reason: "bad times", fatal: true);
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
