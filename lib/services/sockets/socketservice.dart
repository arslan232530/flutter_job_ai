import 'package:job_board/controllers/chat/chat_notifier.dart';
import 'package:job_board/controllers/message/message_notifier.dart';
import 'package:job_board/models/response/message/message_response.dart';
import 'package:job_board/services/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late io.Socket socket;
  bool _isSetup = false;

  void connect(
    String userId,
    ChatController chatNotifier,
    String chatId,
    MessageNotifier messageNotifier,
  ) {
    if (_isSetup) return; // prevent duplicate setup
    _isSetup = true;
    socket = io.io(Config.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoconnect': false,
    });
    socket.emit('setup', userId);
    socket.connect();
    socket.onConnect((_) {
      socket.on('online-users', (users) {
        List<String> online = [];

        if (users is String) {
          online = [users]; // wrap single user in list
        } else if (users is List) {
          online = List<String>.from(users); // already a list
        }

        chatNotifier.setOnlineUsers(online);
      });
      socket.on('typing', (status) {
        chatNotifier.setTypingStatus(status);
      });

      socket.on('stop typing', (status) {
        chatNotifier.setTypingStatus(status);
      });
      socket.on('message received', (newMessageReceived) {
        sendStopTypingEvent(chatId);
        final ReceivedMessage receivedMessage = ReceivedMessage.fromJson(
          newMessageReceived,
        );
        if (receivedMessage.sender.id != userId) {
          messageNotifier.addIncomingMessage(receivedMessage);
        }
      });
    });
  }

  void sendTypingEvent(String chatId) {
    socket.emit('typing', chatId);
  }

  void joinChat(String chatId) {
    socket.emit('join chat', chatId);
  }

  void sendStopTypingEvent(String chatId) {
    socket.emit('stop typing', chatId);
  }

  void emitNewMessage(Map<String, dynamic> data, String chatId) {
    socket.emit('new message', data);
    sendStopTypingEvent(chatId);
  }

  void dispose() {
    socket.disconnect();
  }
}
