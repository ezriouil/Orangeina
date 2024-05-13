import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends CustomState {
  const HomeScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("home screen", style: Theme.of(context).textTheme.bodyLarge)),
    );
  }
}
