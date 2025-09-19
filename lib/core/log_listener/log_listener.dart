import 'dart:async';

import 'package:ignite_dev_tools/core/event/log_event.dart';
import 'package:ignite_dev_tools/core/event_bus/event_data_bus.dart';
import 'package:ignite_dev_tools/core/locator.dart';
import 'package:ignite_dev_tools/core/log_listener/loger_tcp_client.dart';
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
    initialize();
  }

  final TcpClient _client = TcpClient();
  Timer? _timer;

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    await _client.connect();
    _client.listenForResponse((message) {
      _runParser(message);
    });

    _dataBus.listen<GetLogsEvent>((event) {
      _client.sendMessage(event.code);
    });

    await Future.delayed(const Duration(seconds: 1));
    _client.sendMessage(GetLogsEvent().code);
    _periodicUpdate();
  }

  void _periodicUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _client.sendMessage(GetLogsEvent().code);
    });
  }

  Future<void> _runParser(String message) async {
    // final logs = await rootBundle.loadString('assets/debug.log');
    final result = await _parseLogsInBackground(message);
    if (result is ObjectNode) {
      _dataBus.emit<NewLogEvent>(NewLogEvent(result));
    }
  }

  Future<ASTNode> _parseLogsInBackground(String message) async {
    final List<Token> output = Tokenizer().tokenize(message);
    final ASTNode nodes = Parser().parseValue(output);
    return nodes;
  }

  void dispose() {
    _timer?.cancel();
    _client.close();
  }
}
