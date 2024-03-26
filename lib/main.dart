import 'package:flutter/material.dart';

import 'views/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Home(), debugShowCheckedModeBanner: false);
}
