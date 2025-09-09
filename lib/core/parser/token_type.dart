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
  const ObjectNode(this.value);

  @override
  String toString() => 'ObjectNode{ $value }';
}

final class ArrayNode extends ASTNode {
  final List<ASTNode> value;
  const ArrayNode(this.value);

  @override
  String toString() => 'ArrayNode{ $value }';
}

final class StringNode extends ASTNode {
  final String value;
  const StringNode(this.value);

  @override
  String toString() => 'StringNode{ $value }';
}

final class NumberNode extends ASTNode {
  final num value;
  const NumberNode(this.value);

  @override
  String toString() => 'NumberNode{ $value }';
}

final class BooleanNode extends ASTNode {
  final bool value;
  const BooleanNode(this.value);

  @override
  String toString() => 'BooleanNode{ $value }';
}

final class NullNode extends ASTNode {}
