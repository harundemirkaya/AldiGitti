// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/ViewModels/MessageChatViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';

class MessageChatPage extends StatefulWidget {
  final String uid;
  const MessageChatPage({super.key, required this.uid});

  @override
  State<MessageChatPage> createState() => _MessageChatPageState();
}

class _MessageChatPageState extends State<MessageChatPage> {
  MessageChatViewModel viewModel = MessageChatViewModel();
  String userName = "";
  List<String> messages = ["Deneme 1", "Deneme 2", "Deneme 3"];
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    String name = await viewModel.fetchRemoteUserName(widget.uid);
    setState(() {
      userName = name;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryNavigationBar(
            backButton: true,
            userName: userName,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          messages[index],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Spacer(),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryTextField(
                    controller: _messageController,
                    icon: Icons.message_outlined,
                    placeholderText: "Mesajınız",
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // TO DO
                    },
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
