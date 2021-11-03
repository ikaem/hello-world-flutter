// import 'dart:io';
// import "dart:async";

// import 'dart:isolate';

// // Future<void> longRunningOperation() async {
// Future<void> longRunningOperation(String message) async {
//   for (int i = 0; i < 5; i++) {
//     // sleep is cool - it just sleeps for some period of time
//     // it is synchronous
//     // Duration is just a difference in time?
//     // sleep(Duration(seconds: 1));
//     // note how we use named argument here
//     await Future.delayed(Duration(seconds: 1));
//     print("$message: $i");
//   }
// }

// // have to mark main function as async
// main() async {
// // creating an isolate here

//   print("Start of long running operation");
//   // longRunningOperation();

//   Isolate.spawn(longRunningOperation, "hello");

//   print("continue in main body");

//   for (int i = 10; i < 15; i++) {
//     // sleep is cool - it just sleeps for some period of time
//     // it is synchronous
//     // Duration is just a difference in time?
//     // sleep(Duration(seconds: 1));
//     await Future.delayed(Duration(seconds: 1));
//     print("index: $i");
//   }

//   print("end of main");
// }

// // void main() {
// //   List placeNames = ["Middlesbrough", "New York"];

// //   // we want to avoid this - we only want strings
// //   placeNames.add(1);

// //   List<String> goodPlaceNames = ["Zadar", "Pula"];
// //   goodPlaceNames.add(2); // this does not compile

// //   // this is a list of strings
// //   var placeNamesAgain = <String>["Pula", "Zadar"];

// //   // this is a map of string keys, and int values
// //   var richness = <String, int>{
// //     "rich": 50,
// //     "ok": 30,
// //     "poor": 10,
// //   };

// //   var emptyObject = <String, int>{};

// //   var landmarks = <String, String?>{
// //     "Zadar": "Organs",
// //     "Pula": "Aphitheatre",
// //     "Žepče": null,
// //   };
// // }

// // // // class Person {
// // // //   // no need for late
// // // //   // late String firstName;
// // // //   // late String lastName;

// // // //   late String firstName;
// // // //   late String lastName;

// // // //   Person(this.firstName, this.lastName);
// // // //   Person.anonymous();

// // // //   // Person(String this.firstName, String lastName) {
// // // //   //   this.firstName = firstName;
// // // //   //   this.lastName = lastName;
// // // //   // }

// // // //   String getFullName() => "$firstName $lastName";

// // // // // this is just an example
// // // // // this is a cosntructor too, os it has ot be inside a class
// // // //   // factory Person.fromCache(String firstName, String lastName) {
// // // //   //   if (_cacheService.containsPerson(firstName, lastName)) {
// // // //   //     return _cacheService.getPerson(firstName, lastName);
// // // //   //   } else {
// // // //   //     return Person(firstName, lastName);
// // // //   //   }
// // // //   // }
// // // // }

// // // // just an example of the abstract class

// // // // import 'package:flutter/foundation.dart';

// // // enum PersonType { student, employee }

// // // abstract class Person {
// // //   String firstName;
// // //   String lastName;

// // //   PersonType? type;

// // //   Person(this.firstName, this.lastName);
// // //   String get fullName;
// // //   // late String firstName;
// // //   // late String lastName;

// // //   // Person(this.firstName, this.lastName);
// // //   // Person.anonymous();

// // //   // String getFullName() => "$firstName $lastName";
// // // }

// // // // these are classes that are mixins i guess - or will be used as mixins
// // // class ProgrammingSkills {
// // //   coding() {
// // //     print("Writing code...");
// // //   }
// // // }

// // // class ManagementSkills {
// // //   manage() {
// // //     print("Managing project...");
// // //   }
// // // }

// // // class SeniorDeveloper extends Person with ProgrammingSkills, ManagementSkills {
// // //   SeniorDeveloper(String firstName, String lastName)
// // //       : super(firstName, lastName);

// // //   String get fullName => "Hello Senior developer";

// // //   // ow here in the dseior eveoper, we actually have available the "coding" and "managing" methods
// // // }

// // // // class Student extends Person {
// // // //   String nickname;

// // // //   Student(String firstName, String lastName, this.nickname)
// // // //       : super(firstName, lastName);

// // // //   @override
// // // //   String toString() => "$fullName aka $nickname";

// // // //   @override
// // // //   String get fullName => "$firstName $lastName";
// // // // }

// // // // just testing a class implementing an interface

// // // class Student implements Person {
// // //   // this is Student's own memeber
// // //   String nickname;

// // // // these are now members that existing in the class we are implementing onto Student class
// // //   @override
// // //   String firstName;

// // //   @override
// // //   String lastName;

// // //   @override
// // //   PersonType? type = PersonType.student;

// // // // we dont need to call super
// // //   Student(this.firstName, this.lastName, this.nickname);

// // //   @override
// // //   String get fullName => "$firstName $lastName";

// // //   @override
// // //   String toString() => "$fullName, also knoww nas $nickname";
// // // }

// // // void main() {
// // //   // var anonymousPerson = Person.anonymous();

// // //   SeniorDeveloper seniorDev = SeniorDeveloper("karlo", "Marinovic");

// // //   seniorDev.manage();

// // //   Student newStudent = Student("Karlo", "Marinović", "karlo");
// // //   newStudent.type = PersonType.student;

// // //   print(newStudent.type);
// // //   print(newStudent.type?.index); // 0
// // //   // print(describeEnum(PersonType));
// // //   // print(describeEnum(PersonType.student));

// // //   print(newStudent); // Karlo Marinović aka karlo
// // // }

// // // // class Person {
// // // //   String? firstName;
// // // //   String? lastName;
// // // //   static String greetingLabel = "Hello: ";
// // // //   static void justPrintPersonInstance(Person person) {
// // // //     print("$greetingLabel ${person.lastName} ${person.firstName}");
// // // //   }

// // // // // shorter syntax for the function
// // // //   String getFullName() => "$firstName $lastName";

// // // //   // this is a getter now // we just add get

// // // //   String get greetPerson => "$greetingLabel $firstName $lastName";
// // // //   String get fullName => "$firstName $lastName";
// // // //   String get initials => "${firstName?[0]}.${lastName?[0]}.";

// // // //   set fullName(String fullName) {
// // // // // this is cool - we get a list when we split
// // // //     var parts = fullName.split(" ");
// // // //     this.firstName = parts.first;
// // // //     this.lastName = parts.last;
// // // //   }
// // // // }

// // // // void main() {
// // // // // note here that the class becomes type?
// // // //   Person newPerson1 = Person();
// // // //   newPerson1.firstName = "Karlo";
// // // //   newPerson1.lastName = "Marinović";

// // // //   // print(newPerson1.getFullName());

// // // //   Person newPerson2 = Person();
// // // //   newPerson2.firstName = "Ivan"; //
// // // //   newPerson2.lastName = "Marinović";

// // // //   print(newPerson1.greetPerson); // Hello:  Karlo Marinović
// // // //   print(newPerson2.greetPerson);

// // // //   Person.greetingLabel = "Hi, ";

// // // //   Person.justPrintPersonInstance(newPerson2);

// // // //   print(newPerson1.greetPerson); // Hi,   Karlo Marinović
// // // //   print(newPerson2.greetPerson);

// // // //   // print(newPerson.initials); // K.M.
// // // // }

// // // // // import 'dart:math';

// // // // // sayHi() {
// // // // //   // this is dynamic type
// // // // //   return "hello";
// // // // // }

// // // // // String sayHappyBirthday(String name, int age) {
// // // // //   return "$name, happy birthday nr $age";
// // // // // }

// // // // // String optionalBirthdayAgeGretting(String name,
// // // // //     [int? age, String? lastName, address, city = "Pula"]) {
// // // // //   int defaultAge = 13;

// // // // //   if (age != null) defaultAge = age;

// // // // //   return "$name, not sure which birthday is this now? Number $defaultAge?";
// // // // // }

// // // // // String namedFunctionParameters(String name,
// // // // //     {int? age, String lastName = "", required String city}) {
// // // // //   return "Karlo";
// // // // // }

// // // // // void main() {
// // // // //   List<int> list = [1, 2, 3, 4];

// // // // //   list.forEach((number) => print("hello, $number"));

// // // // //   optionalBirthdayAgeGretting("karlo", 23, "marinovic");

// // // // //   namedFunctionParameters("Karlo",
// // // // //       age: 21, lastName: "Marinovic", city: "Pula");

// // // // //   var helloFunction = sayHi();
// // // // //   print(helloFunction); // hello

// // // // //   // for (int i = 0; i < 5; i++) {
// // // // //   //   print("hello ${i + 1}");
// // // // //   // }

// // // // //   print(sayHello());

// // // // //   // var isTrue = true;

// // // // //   // if (isTrue) print("this is without curly braces");
// // // // // }

// // // // // // i guess this will return a string
// // // // // // String sayHello() {
// // // // // // this is in case that tthe return type can be null
// // // // // String? sayHello() {
// // // // //   var randomNumber = Random().nextInt(100);

// // // // //   print(randomNumber);

// // // // //   if (randomNumber < 50) return null;

// // // // //   return "Hello World";
// // // // // }

// // // // // // // inferrend string type variable
// // // // // // var name = "karlo";

// // // // // // // this is a nullable variable
// // // // // // int? newNullableNumber; // -> this variable can now be nullable

// // // // // // late int newLateNumber; // this allows nullability too

// // // // // // int? goals;

// // // // // // String? goalScorer;
// // // // // // bool goalScored = false;

// // // // // // List dynamicList = [];

// // // // // // List someFixedLengthList = List.filled(3, "Fixed value");

// // // // // // Map someAgeMap = {};

// // // // // // String thisIsSomeString = "this is my name";
// // // // // // String thisIsMyNameSingleQuotes = "karlo";
// // // // // // // the tab in the last line will be preserved
// // // // // // String thisIsMultilineStirng = """My name is Kalrlo
// // // // // // Multiline
// // // // // //   This tab will be preserved""";

// // // // // // const String someConstantString = "this is a constant";
// // // // // // final String someFinalString = DateTime.now().toString();

// // // // // // void main() {
// // // // // //   String concatanatedString = thisIsSomeString + thisIsMyNameSingleQuotes;

// // // // // //   String repeatedString = thisIsSomeString * 3;

// // // // // //   print(
// // // // // //       "this is repeated $repeatedString"); // this is repeated this is my namethis is my namethis is my name

// // // // // //   someAgeMap["karlo"] = 23;
// // // // // //   print(someAgeMap["karlo"]); // 23

// // // // // //   dynamicList.add(1);
// // // // // //   // seems we can combine types into the list
// // // // // //   dynamicList.add("karlo");

// // // // // //   print("this is a list: $dynamicList");

// // // // // // // also note that remove reoves specific item that it searches - the first occurence
// // // // // //   dynamicList.remove("karlo");

// // // // // //   print("this is list after removing $dynamicList");

// // // // // //   if (goalScorer != null) {
// // // // // //     print(goalScorer?.length);
// // // // // //   }

// // // // // //   print(goalScorer?.length);

// // // // // //   goals = 13;
// // // // // //   if (goals != null) {
// // // // // //     // this is not even allowed, because something seems to be checking for this value
// // // // // //     print(goals! + 2);
// // // // // //   }

// // // // // //   newLateNumber = 33;
// // // // // //   print("this is late variable $newLateNumber");

// // // // // //   print(newNullableNumber); // null
// // // // // // }
