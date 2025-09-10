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

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    final TcpClient client = TcpClient();
    await client.connect();
    client.listenForResponse((message) {
      _runParser(message);
    });

    _dataBus.listen<GetLogsEvent>((event) {
      client.sendMessage(event.code);
    });

    client.sendMessage(GetLogsEvent().code);
  }

  Future<void> _runParser(String message) async {
    // final logs = await rootBundle.loadString('assets/debug.log');

    final List<Token> output = Tokenizer().tokenize(message);
    final ASTNode nodes = Parser().parseValue(output);

    if (nodes is ObjectNode) {
      _dataBus.emit<NewLogEvent>(NewLogEvent(nodes));
    }
  }
}
