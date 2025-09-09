import 'package:shadcn_flutter/shadcn_flutter.dart';

class UIViewTreeWidget extends StatelessWidget {
  const UIViewTreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(10),
        Text('UIView Tree').small.mono.withPadding(horizontal: 16),
        Divider().withPadding(vertical: 10),
        Expanded(child: Container()),
      ],
    );
  }
}
