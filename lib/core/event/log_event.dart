import 'package:ignite_dev_tools/core/parser/token_type.dart';

final class NewLogEvent {
  final ObjectNode tree;

  const NewLogEvent(this.tree);
}

final class GetLogsEvent {
  const GetLogsEvent();

  final String code = "GET_LOG";
}
