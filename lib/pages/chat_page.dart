import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [
    
  ];

  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: const Text('Te', style: TextStyle(fontSize: 12))
            ), 
            const SizedBox(height: 3),
            const Text('Algún nombre washo', style: TextStyle(color: Colors.black87, fontSize: 12))
          ]
        ),
        centerTitle: true,
        elevation: 1
      ),
      body: Container(
        child: Column(
          children: [

            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true
              )
            ),

            const Divider(height: 1),

            // Caja de texto
            Container(
              color: Colors.white,
              child: _inputChat()
            )
          ]
        )
      )
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [

            Flexible(
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                onSubmitted: _handleSubmit,
                onChanged: (texto) {
                  setState(() {
                    if(texto.isNotEmpty) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar'
                )
              )
            ),

            // Botón de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS 
                ? CupertinoButton(
                    onPressed: (){},
                    child: const Text('Enviar'), 
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: const Icon(Icons.send),
                        onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null 
                      )
                    )
                  )
            )

          ]
        )
      )
    );
  }

  _handleSubmit(String texto) {

    if (texto.isEmpty) {
      return;
    }
    
    _focusNode.requestFocus();
    _textController.clear();

    final newMessage = ChatMessage(
      texto: texto, 
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400)
      )
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    
    for(ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }
  
}