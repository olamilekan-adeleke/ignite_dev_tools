import 'package:shadcn_flutter/shadcn_flutter.dart';

class UiViewTreeDetailWidget extends StatelessWidget {
  const UiViewTreeDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Gap(10),
      Text('UIView Tree Detail').small.mono.withPadding(horizontal: 16),
      Divider().withPadding(vertical: 10),
    ]);
  }
}
