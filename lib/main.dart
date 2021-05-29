import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'journalinput.dart';
import 'routing.dart';
import 'profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Home.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class Home extends StatefulWidget {
  static String id = '/';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String journalId = Jiffy(DateTime.now()).format('yyyymmdd');

  Future<bool> loadTodaysJournalText() async {
    String contents = "";
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    try {
      final file = File('$path/$journalId.txt');
      contents = await file.readAsString();
    } catch (e) {}
    final _ = await Navigator.pushNamed(
      context,
      JournalInput.id,
      arguments: JournalInputArguments(contents),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final appView = AppBar(
      title: Text('Garuna'),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
          child: InkWell(
            onTap: () async {
              await Navigator.pushNamed(context, Profile.id);
              setState(() {});
            },
            child: Hero(
              tag: 'logo',
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/profile.jpeg',
                ),
                radius: 32,
              ),
            ),
          ),
        ),
      ],
    );
    final bodyScrollView = SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "HELLO",
            style: Theme.of(context).textTheme.headline3,
          ),
          ElevatedButton(
            onPressed: loadTodaysJournalText,
            child: Text("Todays Journal"),
          ),
        ],
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appView,
      body: bodyScrollView,
    );
  }
}
