import 'package:uuid/uuid.dart';

import 'token_type.dart';

final class Parser {
  Parser();

  int currentIndex = 0;
  void _eatToken() => currentIndex++;
  bool _hasMoreTokens(List<Token> tokens) => currentIndex < tokens.length;

  Token _getCurrentToken(List<Token> tokens) {
    if (!_hasMoreTokens(tokens)) throw Exception('Unexpected end of input');
    return tokens[currentIndex];
  }

  ASTNode parseValue(List<Token> tokens, {String? name}) {
    if (tokens.isEmpty) return NullNode();

    final Token token = _getCurrentToken(tokens);

    final bool hasMore = _hasMoreTokens(tokens);
    final bool isObjectAhead =
        hasMore && tokens[currentIndex + 1].type == TokenType.BraceOpen;
    if (isObjectAhead) {
      _eatToken(); //
      return _parseObject(tokens, name: token.value);
    }

    return switch (token.type) {
      TokenType.String => StringNode(token.value),
      TokenType.Number => NumberNode(num.parse(token.value)),
      TokenType.Boolean => BooleanNode(bool.parse(token.value)),
      TokenType.BraceOpen => _parseObject(tokens, name: name),
      TokenType.BracketOpen => _parseList(tokens),
      TokenType.Null => NullNode(),
      _ => NullNode(),
    };
  }

  ASTNode _parseObject(List<Token> tokens, {String? name}) {
    Map<String, ASTNode> nodes = {};
    _eatToken();

    Token token = _getCurrentToken(tokens);
    while (token.type != TokenType.BraceClose) {
      // Should start with a string a colon and another string
      if (token.type == TokenType.String) {
        final key = token.value;
        _eatToken();
        token = _getCurrentToken(tokens);

        if (token.type != TokenType.Colon) {
          throw Exception('Expected : in key-value pair');
        }
        _eatToken();
        token = _getCurrentToken(tokens);

        final value = parseValue(tokens, name: key);
        nodes[key] = value;
      } else {
        throw Exception("String key in object. Token type: '${token.type}'");
      }

      _eatToken();
      token = _getCurrentToken(tokens);
      if (token.type == TokenType.Comma) {
        _eatToken();
        token = _getCurrentToken(tokens);
      }
    }

    return ObjectNode(nodes, name ?? "-----", id: Uuid().v4());
  }

  ASTNode _parseList(List<Token> tokens) {
    final List<ASTNode> nodes = [];

    _eatToken();
    Token token = tokens[currentIndex];

    while (token.type != TokenType.BracketClose) {
      final value = parseValue(tokens);
      nodes.add(value);

      _eatToken();
      token = _getCurrentToken(tokens);

      if (token.type == TokenType.Comma) {
        _eatToken();
        token = _getCurrentToken(tokens);
      }
    }

    return ArrayNode(nodes, id: Uuid().v4());
  }
}
