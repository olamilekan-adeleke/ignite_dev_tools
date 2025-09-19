// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_inspector_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ViewInspectorUiState {
  ObjectNode? get tree;

  /// Create a copy of ViewInspectorUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewInspectorUiStateCopyWith<ViewInspectorUiState> get copyWith =>
      _$ViewInspectorUiStateCopyWithImpl<ViewInspectorUiState>(
          this as ViewInspectorUiState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewInspectorUiState &&
            (identical(other.tree, tree) || other.tree == tree));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tree);

  @override
  String toString() {
    return 'ViewInspectorUiState(tree: $tree)';
  }
}

/// @nodoc
abstract mixin class $ViewInspectorUiStateCopyWith<$Res> {
  factory $ViewInspectorUiStateCopyWith(ViewInspectorUiState value,
          $Res Function(ViewInspectorUiState) _then) =
      _$ViewInspectorUiStateCopyWithImpl;
  @useResult
  $Res call({ObjectNode? tree});
}

/// @nodoc
class _$ViewInspectorUiStateCopyWithImpl<$Res>
    implements $ViewInspectorUiStateCopyWith<$Res> {
  _$ViewInspectorUiStateCopyWithImpl(this._self, this._then);

  final ViewInspectorUiState _self;
  final $Res Function(ViewInspectorUiState) _then;

  /// Create a copy of ViewInspectorUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tree = freezed,
  }) {
    return _then(_self.copyWith(
      tree: freezed == tree
          ? _self.tree
          : tree // ignore: cast_nullable_to_non_nullable
              as ObjectNode?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ViewInspectorUiState].
extension ViewInspectorUiStatePatterns on ViewInspectorUiState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ViewInspectorUiState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ViewInspectorUiState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ViewInspectorUiState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ViewInspectorUiState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ViewInspectorUiState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ViewInspectorUiState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(ObjectNode? tree)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ViewInspectorUiState() when $default != null:
        return $default(_that.tree);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(ObjectNode? tree) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ViewInspectorUiState():
        return $default(_that.tree);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(ObjectNode? tree)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ViewInspectorUiState() when $default != null:
        return $default(_that.tree);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ViewInspectorUiState implements ViewInspectorUiState {
  const _ViewInspectorUiState({this.tree = null});

  @override
  @JsonKey()
  final ObjectNode? tree;

  /// Create a copy of ViewInspectorUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ViewInspectorUiStateCopyWith<_ViewInspectorUiState> get copyWith =>
      __$ViewInspectorUiStateCopyWithImpl<_ViewInspectorUiState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ViewInspectorUiState &&
            (identical(other.tree, tree) || other.tree == tree));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tree);

  @override
  String toString() {
    return 'ViewInspectorUiState(tree: $tree)';
  }
}

/// @nodoc
abstract mixin class _$ViewInspectorUiStateCopyWith<$Res>
    implements $ViewInspectorUiStateCopyWith<$Res> {
  factory _$ViewInspectorUiStateCopyWith(_ViewInspectorUiState value,
          $Res Function(_ViewInspectorUiState) _then) =
      __$ViewInspectorUiStateCopyWithImpl;
  @override
  @useResult
  $Res call({ObjectNode? tree});
}

/// @nodoc
class __$ViewInspectorUiStateCopyWithImpl<$Res>
    implements _$ViewInspectorUiStateCopyWith<$Res> {
  __$ViewInspectorUiStateCopyWithImpl(this._self, this._then);

  final _ViewInspectorUiState _self;
  final $Res Function(_ViewInspectorUiState) _then;

  /// Create a copy of ViewInspectorUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tree = freezed,
  }) {
    return _then(_ViewInspectorUiState(
      tree: freezed == tree
          ? _self.tree
          : tree // ignore: cast_nullable_to_non_nullable
              as ObjectNode?,
    ));
  }
}

// dart format on
