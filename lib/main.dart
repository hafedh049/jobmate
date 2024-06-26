import 'package:flutter/material.dart';
import 'package:jobmate/utils/callbacks.dart';

import 'views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Home(), debugShowCheckedModeBanner: false);
}
