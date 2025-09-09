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
          ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomeTabPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            RichText(
              text: TextSpan(
                text: '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
