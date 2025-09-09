import 'package:ignite_dev_tools/feature/view_inspector/widgets/ui_view_tree_detail_widget.dart';
import 'package:ignite_dev_tools/feature/view_inspector/widgets/ui_view_tree_widget.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ViewInspectorPage extends StatelessWidget {
  const ViewInspectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = MediaQuery.of(context).size.width;
      final availableHeight = MediaQuery.of(context).size.height * 0.85;

      return OutlinedContainer(
        child: ResizablePanel.horizontal(
          draggerBuilder: (context) {
            return const HorizontalResizableDragger();
          },
          children: [
            ResizablePane(
              initialSize: width * 0.3,
              minSize: width * 0.2,
              child: SizedBox(
                height: availableHeight,
                child: UIViewTreeWidget(),
              ),
            ),
            ResizablePane(
              initialSize: width * 0.7,
              minSize: width * 0.4,
              child: SizedBox(
                height: availableHeight,
                child: UiViewTreeDetailWidget(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
