import 'package:cobalagi2/model/chat.dart';
import 'package:cobalagi2/util/getUser.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

class ChatPage extends StatefulWidget {
  final int idMapel;

  ChatPage({required this.idMapel});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController pesanController = TextEditingController();
  List<Chat> chats = [];
  int userId = UserUtil.getUserId();
  @override
  void initState() {
    super.initState();
    getChats();
  }

  Future<void> getChats() async {
    List<Chat> hasilChats = await getChatsByMapelId(widget.idMapel);

    setState(() {
      chats = hasilChats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // itemCount: chats.length,
              itemCount: chats.length,
              itemBuilder: (context, index) {
                Chat chat = chats[index];
                bool isCurrentUser = chat.userId == userId;

                return ListTile(
                  title: Text(chat.pesan),
                  subtitle: Text('${chat.userId}'),
                  tileColor: isCurrentUser ? Colors.blue[100] : null,
                  contentPadding: isCurrentUser
                      ? EdgeInsets.only(right: 16.0)
                      : EdgeInsets.only(left: 16.0),
                );
              },
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     // itemCount: chats.length,
          //     // itemBuilder: (context, index) {
          //     //   return ListTile(
          //     //     title: Text(chats[index].pesan),
          //     //     subtitle: Text('Dikirim oleh: ${chats[index].userId}'),
          //     //   );
          //     // },

          //     itemCount: 3,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text('Mantap 123'),
          //         subtitle: Text('Dikirim oleh: Whitnu'),
          //       );
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pesanController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    kirimPesan(widget.idMapel, pesanController.text);
                    pesanController.clear();
                    getChats();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> kirimPesan(int idMapel, String pesan) async {
    int userId = UserUtil.getUserId();
    String url = 'URL_API/chat';

    Map<String, dynamic> requestData = {
      'id_user': userId,
      'id_mapel': idMapel,
      'pesan': pesan,
    };

    try {
      dio.Response response = await dio.Dio().post(url, data: requestData);

      if (response.statusCode == 200) {
        print('Pesan berhasil dikirim');
      } else {
        print('Gagal mengirim pesan. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  Future<List<Chat>> getChatsByMapelId(int idMapel) async {
    String url = 'URL_API/chat/mapel/$idMapel';

    try {
      dio.Response response = await dio.Dio().get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<Chat> chats = data.map((json) => Chat.fromJson(json)).toList();

        return chats;
      } else {
        print('Gagal mendapatkan data chat. Status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
      return [];
    }
  }
}
