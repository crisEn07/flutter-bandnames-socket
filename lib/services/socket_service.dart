import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    print('initConfig');
    // Dart client
    this._socket = IO.io('http://100.100.100.239:8080', {
      'transports': ['websocket'],
      'autoConnect': true,
      // optional
    });
    this._socket.connect();

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje: $payload');
    // });
  }
}
