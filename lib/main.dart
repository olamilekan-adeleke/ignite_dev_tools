import 'package:flutter/material.dart';
import 'package:ignite_dev_tools/core/locator.dart';
import 'package:ignite_dev_tools/feature/home/view/home_tab_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return shadcn.ShadcnApp(
      title: 'Flutter Demo',
      theme: shadcn.ThemeData(
          // colorScheme: shadcn.LegacyColorSchemes.darkZinc(),
          // colorScheme: shadcn.LegacyColorSchemes.darkStone(),
          ),
      home: HomeTabPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
