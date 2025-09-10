import 'package:get_it/get_it.dart';
import 'package:ignite_dev_tools/core/event_bus/event_data_bus.dart';

import 'package:ignite_dev_tools/core/log_listener/log_listener.dart';
import 'package:ignite_dev_tools/core/parser/parser.dart';
import 'package:ignite_dev_tools/core/parser/tokenizer.dart';
import 'package:ignite_dev_tools/feature/view_inspector/view_model/view_inspector_view_model.dart';

final getIt = GetIt.instance;

void setUpLocator() {
  getIt
    ..registerSingleton<IgniteUIDataBus>(IgniteUIDataBus())
    ..registerSingleton<LogListener>(
      LogListener(parser: Parser(), tokenizer: Tokenizer()),
    );

  getIt.registerSingleton<ViewInspectorViewModel>(ViewInspectorViewModel(
    dataBus: getIt(),
  ));
}
