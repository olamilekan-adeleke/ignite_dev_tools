import 'package:ignite_dev_tools/core/event/log_event.dart';
import 'package:ignite_dev_tools/core/event_bus/event_data_bus.dart';
import 'package:ignite_dev_tools/core/locator.dart';
import 'package:ignite_dev_tools/feature/view_inspector/view_model/view_inspector_view_model.dart';
import 'package:ignite_dev_tools/feature/view_inspector/widgets/tree_icon_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UIViewTreeWidget extends StatefulWidget {
  const UIViewTreeWidget({super.key});

  @override
  State<UIViewTreeWidget> createState() => _UIViewTreeWidgetState();
}

class _UIViewTreeWidgetState extends State<UIViewTreeWidget> {
  List<TreeNode<Node>> treeItems = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getIt<ViewInspectorViewModel>().addListener(() {
        treeItems = getIt<ViewInspectorViewModel>().treeItems;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double iconRightMargin = 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(10),
        Row(children: [
          Icon(LucideIcons.listTree).iconSmall(),
          Gap(10),
          Text('UIView Tree').small.mono,
          const Spacer(),
          GestureDetector(
            onTap: _expandAll,
            child: Icon(BootstrapIcons.arrowsExpand)
                .iconSmall()
                .withMargin(right: iconRightMargin),
          ),
          GestureDetector(
            onTap: _collapseAll,
            child: Icon(BootstrapIcons.arrowsCollapse)
                .iconSmall()
                .withMargin(right: iconRightMargin),
          ),
          GestureDetector(
            onTap: () {
              getIt<IgniteUIDataBus>().emit<GetLogsEvent>(GetLogsEvent());
            },
            child: Icon(RadixIcons.reload).iconSmall(),
          ),
        ]).withPadding(horizontal: 16),
        Divider().withPadding(vertical: 10),
        _treeWidget(),
      ],
    );
  }

  Widget _treeWidget() {
    return TreeView<Node>(
      expandIcon: true,
      shrinkWrap: true,
      nodes: treeItems,
      branchLine: BranchLine.line,
      onSelectionChanged: TreeView.defaultSelectionHandler(treeItems, (val) {
        setState(() => treeItems = val);
      }),
      builder: (_, node) => TreeItemView(
        onPressed: () => getIt<ViewInspectorViewModel>().onTreeTap(
          node.data.id,
        ),
        leading: Icon(getTreeIcon(node.data.value)).iconXSmall(),
        onExpand: TreeView.defaultItemExpandHandler(treeItems, node, (val) {
          setState(() => treeItems = val);
        }),
        child: Text(node.data.value).small.mono,
      ),
    );
  }

  void _expandAll() {
    setState(() => treeItems = treeItems.expandAll());
  }

  void _collapseAll() {
    setState(() => treeItems = treeItems.collapseAll());
  }
}
