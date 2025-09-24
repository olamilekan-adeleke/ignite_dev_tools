import 'dart:io';

import 'core/parser/parser.dart';
import 'core/parser/token_type.dart';
import 'core/parser/tokenizer.dart';

void main(List<String> args) async {
  final file = File(
    '/Users/kodenigma/project/side_quest/ignite_dev_tools/debug_two.log',
    // '/Users/kodenigma/project/side_quest/ignite_dev_tools/debug.log',
  );
  final String logs = file.readAsStringSync();

  ASTNode? textNode;
  // final val = await Isolate.run(() {
  final output = Tokenizer().tokenize(logs);
  // print(output);
  final nodes = Parser().parseValue(output);
  print(nodes);

  if (nodes is ObjectNode) textNode = nodes;
  // return nodes;
  // });

  // compute(
  //   (message) => Tokenizer().tokenize(message),
  //   logs,
  // );
}

// Image(systemName: notification.type.iconName)
//                 .foregroundColor(Color.purple)
//                 .font(.system(size: 20, weight: .medium))
//                 .padding(12)
//                 .background(Color.purple.opacity(0.1))
//                 .cornerRadius(8)
//                 .overlay(RoundedRectangle(cornerRadius: 8).stroke(.accent.opacity(0.3), lineWidth: 1))
