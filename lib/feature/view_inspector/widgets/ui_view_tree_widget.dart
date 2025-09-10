import 'package:ignite_dev_tools/core/locator.dart';
import 'package:ignite_dev_tools/feature/view_inspector/view_model/view_inspector_view_model.dart';
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
        ListenableBuilder(
          listenable: getIt<ViewInspectorViewModel>(),
          builder: (context, _) {
            final tree = getIt<ViewInspectorViewModel>().state?.tree;
            return Expanded(child: Container());
          },
        ),
      ],
    );
  }
}
