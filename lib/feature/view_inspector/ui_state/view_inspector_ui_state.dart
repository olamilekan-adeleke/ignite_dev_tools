import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ignite_dev_tools/core/parser/token_type.dart';

part 'view_inspector_ui_state.freezed.dart';

@freezed
abstract class ViewInspectorUiState with _$ViewInspectorUiState {
  const factory ViewInspectorUiState({
    @Default(null) ObjectNode? tree,
  }) = _ViewInspectorUiState;
}
