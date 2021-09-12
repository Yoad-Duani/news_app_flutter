import 'package:flutter/material.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:splashscreen/splashscreen.dart';

import 'bloc/get_top_headlines_bloc.dart';

void main() {
  runApp(MyApp());
}

MainScreen neWMainScreen = new MainScreen();
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     //   // title: 'Flutter Demo',
//     //   // theme: ThemeData(
//     //   //   primarySwatch: Colors.blue,
//     //   // ),
//     //   home: MainScreen(),
//     // );
//     return SplashScreen(
//         seconds: 14,
//         navigateAfterSeconds: MainScreen(),
//         title: new Text('Welcome In SplashScreen'),
//         image: new Image.asset('assets/img/placeholder.jpg'),
//         backgroundColor: Colors.white,
//         styleTextUnderTheLoader: new TextStyle(),
//         photoSize: 100.0,
//         loaderColor: Colors.red);
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future<dynamic> loadFromFuture() async {
  //   getTopHeadlinesBloc..getHeadlines();
  //   return Future.value(MainScreen());
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: neWMainScreen,
          // navigateAfterFuture: loadFromFuture(),
          title: new Text(
            'News Application',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          image: new Image.asset('assets/img/Y.D.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: () => print("Flutter Egypt"),
          loaderColor: Colors.red),
    );
  }
}
