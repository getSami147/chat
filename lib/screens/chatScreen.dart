import 'package:chat/utils/colors.dart';
import 'package:chat/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Utils/Widget.dart';
import 'chatModel.dart';
import 'sms.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
    // "wss://socketsbay.com/wss/v2/1/demo/"
    'ws://192.168.100.9:4000',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Flash Chats"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrimary,
        onPressed: () {},
        child: const Icon(
          Icons.edit_outlined,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: chat2Model.length,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Sms(
                        name: chat2Model[index].name.toString(),
                        channel: channel,
                      ).launch(context);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage(chat2Model[index].image.toString()),
                      ),
                      title: text(chat2Model[index].name.toString(),
                          fontSize: textSizeMedium),
                      subtitle: text(chat2Model[index].name2.toString(),
                          fontSize: textSizeSMedium,
                          fontWeight: FontWeight.w300,
                          overflow: TextOverflow.ellipsis),
                      trailing: Column(
                        children: [
                          text("16:35"),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff7ce0ff)),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6, top: 1),
                              child: Text(
                                "2",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ).paddingAll(spacing_middle),
                  )
                ],
              ),
            );
          }),
    );
  }
}
