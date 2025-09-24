import 'package:flutter/material.dart';
import 'package:sirs/widgets/chatbot_widget.dart';

class ChatOverlayWrapper extends StatelessWidget {
  final Widget child;
  final bool showChatBot;
  final VoidCallback onClose;
  final String chatContext;

  const ChatOverlayWrapper({
    Key? key,
    required this.child,
    required this.showChatBot,
    required this.onClose,
    required this.chatContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showChatBot)
          Positioned(
            bottom: 20,
            right: 20,
            child: ChatBotWidget(
              onClose: onClose,
              chatContext: chatContext,
            ),
          ),
      ],
    );
  }
}
