// ignore_for_file: constant_identifier_names

enum TokenType {
  BraceOpen, // (
  BraceClose, // )
  BracketOpen, // [
  BracketClose, // ]
  String,
  Number,
  Boolean,
  Comma,
  Colon,
  Null,
}

final class Token {
  final TokenType type;
  final String value;

  Token(this.type, this.value);

  @override
  String toString() => 'Token{$type, "$value"}';
}

sealed class ASTNode {
  const ASTNode();
}

final class ObjectNode extends ASTNode {
  final Map<String, ASTNode> value;
  final String name;
  final String? id;

  const ObjectNode(this.value, this.name, {this.id});

  @override
  String toString() {
    return 'ObjectNode{ name: $name, value: $value }';
  }
}

final class ArrayNode extends ASTNode {
  final List<ASTNode> value;
  final String? id;
  const ArrayNode(this.value, {this.id});

  @override
  String toString() => 'ArrayNode{ $value }';
}

final class StringNode extends ASTNode {
  final String value;
  const StringNode(this.value);

  @override
  String toString() {
    return value;
    // return 'StringNode{ $value }';
  }
}

final class NumberNode extends ASTNode {
  final num value;
  const NumberNode(this.value);

  @override
  String toString() {
    return value.toString();
    // return 'NumberNode{ $value }';
  }
}

final class BooleanNode extends ASTNode {
  final bool value;
  const BooleanNode(this.value);

  @override
  String toString() {
    return value.toString();
    // return 'BooleanNode{ $value }';
  }
}

final class NullNode extends ASTNode {}
