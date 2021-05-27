import 'main.dart';
import 'network/socket/chat.dart';

class SocketManager {
  static final SocketManager _temp = SocketManager._internal();

  factory SocketManager() {
    return _temp;
  }

  SocketManager._internal();

  SocketService socketService = socketInjector.get<SocketService>();
}
