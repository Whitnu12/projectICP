class Chat {
  final int id;
  final int userId;
  final int mapelId;
  final String pesan;
  final DateTime timestamp;

  Chat({
    required this.id,
    required this.userId,
    required this.mapelId,
    required this.pesan,
    required this.timestamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      userId: json['id_user'],
      mapelId: json['id_mapel'],
      pesan: json['pesan'],
      timestamp: DateTime.parse(json['created_at']),
    );
  }
}
