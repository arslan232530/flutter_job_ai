import 'dart:convert';

List<GetChats> getChatsFromJson(String str) =>
    List<GetChats>.from(json.decode(str).map((x) => GetChats.fromJson(x)));

String getChatsToJson(List<GetChats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetChats {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<Sender> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LatestMessage? latestMessage;

  GetChats({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    this.latestMessage,
  });

  factory GetChats.fromJson(Map<String, dynamic> json) => GetChats(
    id: json['_id'],
    chatName: json['chatName'],
    isGroupChat: json['isGroupChat'],
    users: List<Sender>.from(json['users'].map((x) => Sender.fromJson(x))),
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    latestMessage: json['latestMessage'] != null
        ? LatestMessage.fromJson(json['latestMessage'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'chatName': chatName,
    'isGroupChat': isGroupChat,
    'users': List<dynamic>.from(users.map((x) => x.toJson())),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'latestMessage': latestMessage?.toJson(),
  };
}

class LatestMessage {
  final String id;
  final Sender sender;
  final String content;
  final String? receiver;
  final String chat;
  final List<dynamic> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  LatestMessage({
    required this.id,
    required this.sender,
    required this.content,
    this.receiver,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
    id: json['_id'],
    sender: Sender.fromJson(json['sender']),
    content: json['content'],
    receiver: json['receiver'],
    chat: json['chat'],
    readBy: List<dynamic>.from(json['readBy'].map((x) => x)),
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'sender': sender.toJson(),
    'content': content,
    'receiver': receiver,
    'chat': chat,
    'readBy': List<dynamic>.from(readBy.map((x) => x)),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

class Sender {
  final Profile profile;
  final String id;
  final String username;
  final String email;

  Sender({
    required this.profile,
    required this.id,
    required this.username,
    required this.email,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    profile: Profile.fromJson(json['profile']),
    id: json['_id'],
    username: json['username'],
    email: json['email'],
  );

  Map<String, dynamic> toJson() => {
    'profile': profile.toJson(),
    '_id': id,
    'username': username,
    'email': email,
  };
}

class Profile {
  final String url;
  final String publicId;

  Profile({required this.url, required this.publicId});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      Profile(url: json['url'], publicId: json['publicId']);

  Map<String, dynamic> toJson() => {'url': url, 'publicId': publicId};
}
