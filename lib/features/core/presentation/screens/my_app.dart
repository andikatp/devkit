import 'package:devkit/core/flavors/flavor_config.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text(FlavorConfig.instance.values.titleApp)),
      ),
    );
  }
}
