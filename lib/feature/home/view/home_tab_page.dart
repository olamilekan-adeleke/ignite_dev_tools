import 'package:ignite_dev_tools/feature/view_inspector/view/view_inspector_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        headers: [
          AppBar(
            title: const Text('Ignite Devtools').h3,
            trailing: [
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () {},
                child: const Icon(RadixIcons.half2),
              ),
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () {},
                child: const Icon(Icons.search),
              ),
            ],
          ),
        ],
        child: Column(children: [
          TabList(
            index: index,
            onChanged: (value) => setState(() => index = value),
            children: [
              _tabeItem(LucideIcons.searchCode, 'UI View Inspector'),
              _tabeItem(BootstrapIcons.speedometer2, 'Performance'),
            ],
          ),
          const Gap(16),
          IndexedStack(index: index, children: const [
            ViewInspectorPage(),
            Placeholder(),
            Placeholder(),
          ]),
        ]).withPadding(horizontal: 16),
      ),
    );
  }

  TabItem _tabeItem(IconData icon, String text) {
    return TabItem(
      child: Row(spacing: 8, children: [
        Icon(icon),
        Text(text),
      ]),
    );
  }
}
