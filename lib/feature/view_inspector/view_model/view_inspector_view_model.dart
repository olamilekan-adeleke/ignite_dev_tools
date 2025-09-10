import 'package:ignite_dev_tools/core/event/new_log_event.dart';
import 'package:ignite_dev_tools/core/event_bus/event_data_bus.dart';
import 'package:ignite_dev_tools/core/parser/token_type.dart';
import 'package:ignite_dev_tools/feature/view_inspector/ui_state/view_inspector_ui_state.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final class Node {
  final String value;
  final String? id;

  Node(this.value, {this.id});
}

final class ViewInspectorViewModel extends ChangeNotifier {
  final IgniteUIDataBus dataBus;
  ViewInspectorViewModel({required this.dataBus}) {
    dataBus.listen<NewLogEvent>(_logListener);
  }

  ViewInspectorUiState? uiState;
  ViewInspectorUiState? get state => uiState;

  List<TreeNode<Node>> _treeItems = [];
  List<TreeNode<Node>> get treeItems => _treeItems;

  List<TreeNode<Node>> _selectedNode = [];
  List<TreeNode<Node>> get selectedNode => _selectedNode;

  void _logListener(NewLogEvent event) {
    uiState = ViewInspectorUiState(tree: event.tree);
    notifyListeners();

    // debugPrint('tree: ${event.tree}');

    final filteredTree = _filterNodesWithChildrenOrText(event.tree);
    if (filteredTree is! ObjectNode) return;

    _treeItems = _convertToTreeNodes(filteredTree);
    notifyListeners();
  }

  void onTreeTap(String? id) {
    // debugPrint('onTreeTap: $id');

    final tree = uiState?.tree;
    if (tree == null && tree is ObjectNode) return;

    final foundNode = _findNodeByKey(tree!, id);
    if (foundNode != null) {
      _selectedNode = _convertToTreeNodesWith(foundNode);
      // debugPrint('Found node: $foundNode');
    } else {
      _selectedNode.clear();
      debugPrint('Node with key $id not found');
    }

    notifyListeners();
  }

  ObjectNode? _findNodeByKey(ASTNode node, String? id) {
    if (id == null) return null;

    if (node is ObjectNode) {
      if (node.id == id) return node;

      final children = node.value['children'];
      if (children is ArrayNode) {
        for (final child in children.value) {
          final result = _findNodeByKey(child, id);
          if (result != null) return result;
        }
      }
    } else if (node is ArrayNode) {
      for (final child in node.value) {
        final result = _findNodeByKey(child, id);
        if (result != null) return result;
      }
    }

    return null;
  }

  List<TreeNode<Node>> _convertToTreeNodesWith(ASTNode node) {
    final result = <TreeNode<Node>>[];
    debugPrint('node is ${node.runtimeType}');

    if (node is ObjectNode) {
      final name = node.name;
      List<TreeNode<Node>> treeChildren = [];

      final valuse = node.value;
      for (final entry in valuse.entries) {
        final key = entry.key;
        final value = entry.value;
        // if (value is ArrayNode) continue;

        if (value is ObjectNode && value.value['children'] == null) {
          treeChildren.add(TreeItem(
            // data: Node(key),
            data: Node('$key: ${value.value}'),
          ));
        } else if (value is ObjectNode) {
          treeChildren.add(TreeItem(
            data: Node('$key: ${value.value}'),
            children: _convertToTreeNodesWith(value),
          ));
        } else if (value is StringNode) {
          treeChildren.add(TreeItem(
            data: Node('$key: ${value.value}'),
          ));
        } else if (value is NumberNode) {
          treeChildren.add(TreeItem(
            data: Node('$key: ${value.value}'),
          ));
        }
      }

      final children = node.value['children'];
      if (children is ArrayNode && children.value.isNotEmpty) {
        debugPrint('children is ${children.runtimeType}');
        treeChildren.addAll(_convertToTreeNodesWith(children));
      }

      result.add(TreeItem(
        data: Node(name, id: node.id),
        children: treeChildren,
        expanded: true,
      ));
    } else if (node is ArrayNode) {
      for (final child in node.value) {
        // List<TreeNode<Node>> treeChildren = [];

        debugPrint('child is ${child.runtimeType}');
        // if (child is ObjectNode && child.value['children'] == null) {
        // result.add(TreeItem(
        //   data: Node(child.name, id: child.id),
        //   expanded: true,
        // ));
        // }
        // else if (child is ObjectNode) {
        //   result.add(TreeItem(
        //     data: Node('${child.name}: ${child.name}'),
        //     children: _convertToTreeNodesWith(child),
        //   ));
        // }

        result.addAll(_convertToTreeNodesWith(child));
      }
    }

    return result;
  }

  List<TreeNode<Node>> _convertToTreeNodes(ASTNode node) {
    final result = <TreeNode<Node>>[];

    if (node is ObjectNode) {
      final name = node.name;

      final children = node.value['children'];
      if (children is ArrayNode && children.value.isNotEmpty) {
        result.add(TreeItem(
          data: Node(name, id: node.id),
          children: _convertToTreeNodes(node.value['children']!),
          expanded: true,
        ));
      }
    } else if (node is ArrayNode) {
      for (final child in node.value) {
        if (child is ObjectNode && child.value['children'] == null) {
          result.add(TreeItem(
            data: Node(child.name, id: child.id),
            expanded: true,
          ));
        }

        result.addAll(_convertToTreeNodes(child));
      }
    }

    return result;
  }

  ASTNode _filterNodesWithChildrenOrText(ASTNode node) {
    if (node is ObjectNode) {
      final filteredValue = <String, ASTNode>{};
      bool hasChildren = false;
      bool hasText = false;

      for (final entry in node.value.entries) {
        if (entry.key == 'children') {
          final children = _filterNodesWithChildrenOrText(entry.value);
          if (children is ArrayNode && children.value.isNotEmpty) {
            filteredValue[entry.key] = children;
            hasChildren = true;
          }
        } else if (entry.key == 'text') {
          filteredValue[entry.key] = entry.value;
          hasText = true;
        } else {
          final filteredChild = _filterNodesWithChildrenOrText(entry.value);
          if (filteredChild is! NullNode) {
            filteredValue[entry.key] = filteredChild;
          }
        }
      }

      // Keep the node if it has children or text, or if it has nested valid nodes
      if (hasChildren || hasText) {
        return ObjectNode(
          Map.fromEntries(
            filteredValue.entries.map((e) => MapEntry(e.key, e.value)),
          ),
          node.name,
          id: node.id,
        );
        // ..name = node.name; // Preserve the name field
      } else {
        return NullNode();
      }
    } else if (node is ArrayNode) {
      final filteredChildren = node.value
          .map(_filterNodesWithChildrenOrText)
          .where((child) => child is! NullNode)
          .toList();
      return ArrayNode(filteredChildren, id: node.id);
    } else {
      // Keep StringNode, NumberNode, BooleanNode as is
      return node;
    }
  }
}
