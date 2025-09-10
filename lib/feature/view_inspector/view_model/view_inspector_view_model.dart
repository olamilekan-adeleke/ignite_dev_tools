import 'package:flutter/widgets.dart';
import 'package:ignite_dev_tools/core/event/new_log_event.dart';
import 'package:ignite_dev_tools/core/event_bus/event_data_bus.dart';
import 'package:ignite_dev_tools/core/parser/token_type.dart';
import 'package:ignite_dev_tools/feature/view_inspector/ui_state/view_inspector_ui_state.dart';

final class ViewInspectorViewModel extends ChangeNotifier {
  final IgniteUIDataBus dataBus;
  ViewInspectorViewModel({required this.dataBus}) {
    dataBus.listen<NewLogEvent>(_logListener);
  }

  ViewInspectorUiState? uiState;
  ViewInspectorUiState? get state => uiState;

  void _logListener(NewLogEvent event) {
    uiState = ViewInspectorUiState(tree: event.tree);
    notifyListeners();

    debugPrint('tree: ${event.tree}');
    event.tree.value.forEach((key, ASTNode value) {
      debugPrint('$key: $value');
    });
  }
}
