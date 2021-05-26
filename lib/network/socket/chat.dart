import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

const SocketEvents = ["joinPrivate", "newPrivateMessage", 'privateMessage'];

class SocketService {
  IO.Socket socket;

  createSocketConnection() {
    try {
      print("try to connect");
      this.socket = IO.io('http://192.168.1.55:3000', <String, dynamic>{
        'transports': ['websocket']
      });
      this.socket.on("connect", (_) => log('Connected'));
      this.socket.on("disconnect", (_) => log('Disconnected'));
    } catch (e) {
      print(e);
    }
  }

  sendTextMessage(String body, String senderId, String receiverId) {
    this.socket.emit('privateMessage', {
      "body": body,
      "senderId": senderId,
      "receiverId": receiverId,
    });
  }
  void joinPrivate(String senderId,String receiverId) {
    this.socket.emit('joinPrivate', {
      "senderId": senderId,
      "receiverId": receiverId,
    });
  }


}
