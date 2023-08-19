import 'package:chat/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Utils/Colors.dart';
import '../Utils/Widget.dart';

// ignore: must_be_immutable
class Sms extends StatefulWidget {
  var name;

  Sms({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<Sms> createState() => _SmsState();
}

class _SmsState extends State<Sms> {
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
      Uri.parse(
          // 'ws://192.168.100.10:4000',
          // 'wss://echo.websocket.events'
          "wss://socketsbay.com/wss/v2/1/demo/"),
    );
  }

  final messageController = TextEditingController();

  void sendMyMessage() {
    if (messageController.text.isNotEmpty) {
      channel.sink.add(
        messageController.text.toString(),
      );
    }
  }

  @override
  void dispose() {
    channel.sink.close();

    setState(() {
      messageController.clear();
      messageController.dispose();
    });
    super.dispose();
  }

  void _clearInput() {
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now().timeAgo;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(widget.name.toString(), textColor: Colors.white),
            text(time.toString(),
                fontSize: textSizeSmall, textColor: Colors.white),
          ],
        ),
        centerTitle: true,
        actions: [
          const Icon(
            Icons.more_vert,
          ).paddingRight(10)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: StreamBuilder(
            stream: channel.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: snapshot.data.length,
                      //   itemBuilder: (context, index) {
                      // return
                      text(
                          snapshot.hasData ? "Receive:  ${snapshot.data}" : ''),
                      //   },
                      // )
                    ],
                  ).paddingAll(20),
                );
              } else {
                return Center(
                  child: text(
                      snapshot.hasData ? "Receive:  ${snapshot.data}" : '',
                      textColor: Colors.grey,
                      fontSize: textSizeSMedium),
                );
              }
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextFormField(
                  controller: messageController,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: colorPrimary.withOpacity(.3),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: colorPrimary,
                        ),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file_rounded,
                              color: colorPrimary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera,
                              color: colorPrimary,
                            ),
                          )
                        ],
                      ),
                      hintText: 'Message'),
                ),
              ),
              FloatingActionButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: colorPrimary.withOpacity(.3),
                tooltip: "Send Message",
                onPressed: () {
                  sendMyMessage();
                  // print(messageController.text);
                  _clearInput();
                },
                child: const Icon(Icons.send),
              ).paddingLeft(5)
            ],
          ).paddingSymmetric(horizontal: 20).paddingBottom(5),
        ],
      ),
    );
  }
}

// for (int i = 0; i < 2; i++)
//   Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Container(
//         padding: const EdgeInsets.symmetric(
//             horizontal: spacing_standard_new,
//             vertical: spacing_middle),
//         decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//                 bottomRight: Radius.circular(20)),
//             color: colorPrimary),
//         child: text(
//           "Walikum u Salam Navid khan",
//           textColor: Colors.white,
//         ),
//       ),
//       const CircleAvatar(
//         radius: 25,
//         backgroundImage: AssetImage('images/pic.png'),
//       ),
//     ],
//   ).paddingTop(40),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     const CircleAvatar(
//       radius: 25,
//       backgroundImage: AssetImage('images/pic2.png'),
//     ),
//     Container(
//       padding: EdgeInsets.only(top: 20, left: 20),
//       height: 60,
//       width: 220,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//               bottomLeft: Radius.circular(20)),
//           color: Color(0xffffffff)),
//       child: Text(
//         "Alhamdullah bahot ache ",
//         style: TextStyle(color: Color(0xff7ce0ff)),
//       ),
//     ),
//     Icon(
//       Icons.done_all_outlined,
//       size: 20,
//       color: Color(0xff27c1a9),
//     ),
//     Text(
//       "17:48",
//       style: TextStyle(
//           fontSize: 12, color: Color(0xff27c1a9)),
//     )
//   ],
// ),
// SizedBox(
//   height: 10,
// ),
// Row(
//   children: [
//     Padding(
//       padding: const EdgeInsets.only(left: 65),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(30),
//         child: Image.asset(
//           "images/nature.png",
//           height: 190,
//           width: 250,
//         ),
//       ),
//     ),
//     Padding(
//       padding: const EdgeInsets.only(top: 160, left: 10),
//       child: Icon(
//         Icons.done_all_outlined,
//         size: 20,
//         color: Color(0xff27c1a9),
//       ),
//     ),
//     Padding(
//       padding: const EdgeInsets.only(top: 160, left: 1),
//       child: Text(
//         '17:49',
//         style: TextStyle(
//           fontSize: 12,
//           color: Color(0xff27c1a9),
//         ),
//       ),
//     )
//   ],
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: Container(
//         padding: EdgeInsets.only(top: 10, left: 16),
//         height: 60,
//         width: 220,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//                 bottomLeft: Radius.circular(20)),
//             color: Color(0xffffffff)),
//         child: Text(
//           "Acha to ap ki flutter ki study kaha tak pahonche, Sami?",
//           style: TextStyle(color: Color(0xff7ce0ff)),
//         ),
//       ),
//     ),
//   ],
// ),
// SizedBox(
//   height: 10,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Text(
//       "17:14",
//       style: TextStyle(
//           fontSize: 12, color: Color(0xff27c1a9)),
//     ),
//     Icon(
//       Icons.done_all_outlined,
//       size: 20,
//       color: Color(0xff27c1a9),
//     ),
//     Container(
//         padding: EdgeInsets.only(top: 5, left: 20),
//         height: 60,
//         width: 220,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//                 bottomRight: Radius.circular(20)),
//             color: Color(0xff7ce0ff)),
//         child: Row(
//           children: [
//             Icon(
//               Icons.play_circle_outline,
//               color: Colors.white,
//             ),
//             SizedBox(width: 20),
//             Icon(
//               Icons.multitrack_audio_sharp,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.multitrack_audio_sharp,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.multitrack_audio_sharp,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.multitrack_audio_sharp,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.multitrack_audio_sharp,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.multitrack_audio_sharp,
//               color: Colors.white,
//             ),
//           ],
//         )),
//     CircleAvatar(
//       radius: 30,
//       backgroundImage: AssetImage('images/pic.png'),
//     ),
//   ],
// ),
// SizedBox(
//   height: 20,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     CircleAvatar(
//       radius: 25,
//       backgroundImage: AssetImage('images/pic2.png'),
//     ),
//     Container(
//       padding: EdgeInsets.only(top: 20, left: 20),
//       height: 60,
//       width: 220,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//               bottomLeft: Radius.circular(20)),
//           color: Color(0xffffffff)),
//       child: Text(
//         "Alhamdullah bahot ache ",
//         style: TextStyle(color: Color(0xff7ce0ff)),
//       ),
//     ),
//     Icon(
//       Icons.done_all_outlined,
//       size: 20,
//       color: Color(0xff27c1a9),
//     ),
//     Text(
//       "17:48",
//       style: TextStyle(
//           fontSize: 12, color: Color(0xff27c1a9)),
//     )
//   ],
// ),
