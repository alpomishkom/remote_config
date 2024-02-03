import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  var remote = FirebaseRemoteConfig.instance;

  Map<String, Color> colors = {
    "red": Colors.red,
    "yellow": Colors.yellow,
    "black": Colors.black,
    "tealAccent": Colors.tealAccent,
    "brown": Colors.brown,
  };

  String backgroundColor = 'red';

  Future<void> init() async {
     remote.setDefaults({"background_Color": backgroundColor});
    await fetch();
    remote.onConfigUpdated.listen((event) async {
      await fetch();
    });
    setState(() {});
  }

  Future<void> fetch() async {
    await remote.fetchAndActivate().then((value) {
      backgroundColor = remote.getString("background_Color");
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[backgroundColor],
    );
  }
}
