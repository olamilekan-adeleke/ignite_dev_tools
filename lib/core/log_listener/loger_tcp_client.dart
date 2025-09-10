import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

final class TcpClient {
  final String serverAddress;
  final int serverPort;
  Socket? _socket;

  TcpClient({this.serverAddress = '127.0.0.1', this.serverPort = 12345});

  Future<void> connect() async {
    try {
      _socket = await Socket.connect(serverAddress, serverPort);
      debugPrint('Connected to $serverAddress on port $serverPort');
    } catch (e) {
      debugPrint('Error connecting to server: $e');
      _socket = null;
    }
  }

  /// Sends a message to the connected server.
  void sendMessage(String message) {
    if (_socket == null) {
      debugPrint('Not connected to a server. Call connect() first.');
      return;
    }

    try {
      debugPrint('Sending: "$message"');
      _socket?.write(message);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  /// Listens for data from the server.
  void listenForResponse(ValueChanged<String>? onDataReceived) {
    if (_socket == null) {
      debugPrint('Not connected to a server. Cannot listen for response.');
      return;
    }

    // Listen for data on the socket
    _socket?.listen(
      (Uint8List data) {
        final response = utf8.decode(data);
        debugPrint('Received: "$response"');
        onDataReceived?.call(response);
      },
      onDone: () {
        debugPrint('Server disconnected.');
        close();
      },
      onError: (error) {
        debugPrint('Error on socket: $error');
        close();
      },
      cancelOnError: true,
    );
  }

  void close() {
    _socket?.destroy();
    _socket = null;
    debugPrint('Connection closed.');
  }
}
