import 'package:flutter/services.dart';
import 'package:ignite_dev_tools/core/event/new_log_event.dart';
import 'package:ignite_dev_tools/core/event_bus/event_data_bus.dart';
import 'package:ignite_dev_tools/core/locator.dart';
import 'package:ignite_dev_tools/core/parser/parser.dart';
import 'package:ignite_dev_tools/core/parser/token_type.dart';
import 'package:ignite_dev_tools/core/parser/tokenizer.dart';

final class LogListener {
  final Tokenizer tokenizer;
  final Parser parser;
  final IgniteUIDataBus _dataBus;

  LogListener({
    required this.tokenizer,
    required this.parser,
    IgniteUIDataBus? dataBus,
  }) : _dataBus = dataBus ?? getIt<IgniteUIDataBus>() {
    // initialize();
    _runParser();
  }

  // TODO: Consider refactoring into a TCP socket
  void initialize() {
    // final home =
    //     Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

    // final logFilePath = '$home/.config/debug.log';
    // final logFilePath = '$home/project/side_quest/ignite_dev_tools/debug.log';

    // final logFilePath = '/Users/kodenigma/project/side_quest/ignite_dev_tools/';
    // final DirectoryWatcher watcher = DirectoryWatcher(logFilePath);

    // watcher.events.listen((WatchEvent event) {
    //   debugPrint('event: ${event.path}');
    // });
  }

  Future<void> _runParser() async {
    await Future.delayed(const Duration(seconds: 2));
    final logs = await rootBundle.loadString('assets/debug.log');

    final output = Tokenizer().tokenize(logs);
    final nodes = Parser().parseValue(output);

    if (nodes is ObjectNode) {
      _dataBus.emit<NewLogEvent>(NewLogEvent(nodes));
    }
  }
}
