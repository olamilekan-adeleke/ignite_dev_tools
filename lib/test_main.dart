import 'dart:io';

import 'package:ignite_dev_tools/core/parser/parser.dart';

import 'core/parser/tokenizer.dart';

void main(List<String> args) {
  final file = File(
    '/Users/kodenigma/project/side_quest/ignite_dev_tools/debug_two.log',
    // '/Users/kodenigma/project/side_quest/ignite_dev_tools/debug.log',
  );
  final String logs = file.readAsStringSync();
  final output = Tokenizer().tokenize(logs);
  print(output);
  final nodes = Parser().parseValue(output);
  print(nodes);
}
