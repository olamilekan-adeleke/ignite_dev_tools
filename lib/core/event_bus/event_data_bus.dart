import 'package:flutter/material.dart';

typedef IgniteDataEventCallback<T> = void Function(T event);

class IgniteUIDataBus {
  final Map<Type, List<dynamic>> _listeners = {};
  final void Function(Object error, StackTrace st)? onError;

  IgniteUIDataBus({this.onError});

  void listen<T>(IgniteDataEventCallback<T> listener) {
    final key = T;
    final list = _listeners.putIfAbsent(key, () => <dynamic>[]);
    if (!list.contains(listener)) list.add(listener);
  }

  void off<T>(IgniteDataEventCallback<T> listener) {
    final current = _listeners[T];
    if (current == null) return;
    current.remove(listener);
    if (current.isEmpty) _listeners.remove(T);
  }

  void emit<T>(T event) {
    final raw = _listeners[T];
    if (raw == null || raw.isEmpty) return;

    final snapshot = List<Function>.from(raw);
    for (final cb in snapshot) {
      try {
        (cb as IgniteDataEventCallback<T>)(event);
      } catch (e, st) {
        onError?.call(e, st);
        debugPrint('IgniteUIDataBus listener error: $e\n$st');
      }
    }
  }

  bool hasListeners<T>() => (_listeners[T]?.isNotEmpty ?? false);

  void clearFor<T>() => _listeners.remove(T);

  void clearAll() => _listeners.clear();
}
