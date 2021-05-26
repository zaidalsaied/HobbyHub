import 'main.dart';
import 'network/socket/chat.dart';

class ApplicationManager {
  static final ApplicationManager _temp = ApplicationManager._internal();

  factory ApplicationManager() {
    return _temp;
  }

  ApplicationManager._internal();

  SocketService socketService = socketInjector.get<SocketService>();
}
