import 'package:ignite_dev_tools/core/parser/token_type.dart';

final class Tokenizer {
  Tokenizer();

  int currentIndex = 0;
  List<Token> tokenize(String input) {
    List<Token> tokens = [];

    while (currentIndex < input.length) {
      String char = input[currentIndex];

      if (char == '{') {
        tokens.add(Token(TokenType.BraceOpen, '{'));
        currentIndex++;
        continue;
      } else if (char == '}') {
        tokens.add(Token(TokenType.BraceClose, '}'));
        currentIndex++;
        continue;
      } else if (char == '[') {
        tokens.add(Token(TokenType.BracketOpen, '['));
        currentIndex++;
        continue;
      } else if (char == ']') {
        tokens.add(Token(TokenType.BracketClose, ']'));
        currentIndex++;
        continue;
      } else if (char == ',') {
        tokens.add(Token(TokenType.Comma, ','));
        currentIndex++;
        continue;
      } else if (char == ':') {
        tokens.add(Token(TokenType.Colon, ':'));
        currentIndex++;
        continue;
      }

      if (char == '"') {
        String value = "";
        char = input[++currentIndex];
        while (char != '"') {
          value += char;
          char = input[++currentIndex];
        }
        currentIndex++;
        tokens.add(Token(TokenType.String, value));
        continue;
      }

      if (_isAlphaNumeric(char)) {
        String value = "";
        while (_isAlphaNumeric(char)) {
          value += char;
          char = input[++currentIndex];
        }

        if (_isBoolean(value)) {
          tokens.add(Token(TokenType.Boolean, value));
        } else if (_isNull(value)) {
          tokens.add(Token(TokenType.Null, value));
        } else if (_isNumber(value)) {
          tokens.add(Token(TokenType.Number, value));
        } else {
          tokens.add(Token(TokenType.String, value));
        }
        continue;
      }

      if (_isWhitespace(char)) {
        currentIndex++;
        continue;
      }

      throw Exception("Unexpected character: $char");
    }

    return tokens;
  }

  bool _isAlphaNumeric(String char) {
    // print('checking: $char');
    return char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90 ||
        char.codeUnitAt(0) >= 97 && char.codeUnitAt(0) <= 122 ||
        char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57 ||
        char == '.' ||
        char == '_' ||
        char == '-' ||
        char == '+';
  }

  bool _isWhitespace(String char) {
    return char == ' ' || char == '\t' || char == '\n';
  }

  bool _isNumber(String char) {
    return num.tryParse(char) != null;
  }

  bool _isNull(String value) {
    value = value.toLowerCase();
    return value == 'null' || value == 'ptr<null>' || value == 'nullptr';
  }

  bool _isBoolean(String value) {
    value = value.toLowerCase();
    return value == 'true' || value == 'false';
  }
}
