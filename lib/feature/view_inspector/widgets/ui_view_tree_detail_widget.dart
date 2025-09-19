import 'package:ignite_dev_tools/core/locator.dart';
import 'package:ignite_dev_tools/feature/view_inspector/view_model/view_inspector_view_model.dart';
import 'package:ignite_dev_tools/feature/view_inspector/widgets/tree_icon_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UiViewTreeDetailWidget extends StatefulWidget {
  const UiViewTreeDetailWidget({super.key});

  @override
  State<UiViewTreeDetailWidget> createState() => _UiViewTreeDetailWidgetState();
}

class _UiViewTreeDetailWidgetState extends State<UiViewTreeDetailWidget> {
  List<TreeNode<Node>> selectedTreeItems = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getIt<ViewInspectorViewModel>().addListener(() {
        selectedTreeItems = getIt<ViewInspectorViewModel>().selectedNode;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Gap(10),
      Text('UIView Tree Detail').small.mono.withPadding(horizontal: 16),
      Divider().withPadding(vertical: 10),
      Flexible(child: _treeWidget()),
    ]);
  }

  Widget _treeWidget() {
    return TreeView<Node>(
      expandIcon: true,
      shrinkWrap: true,
      nodes: selectedTreeItems,
      branchLine: BranchLine.path,
      builder: (_, node) => TreeItemView(
        leading: Icon(getTreeIcon(node.data.value)).iconXSmall(),
        onExpand:
            TreeView.defaultItemExpandHandler(selectedTreeItems, node, (val) {
          setState(() => selectedTreeItems = val);
        }),
        child: Text(
          node.data.value,
          style: TextStyle(fontWeight: FontWeight.w400),
        ).medium.mono,
      ),
    );
  }
}
