import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatAssistant extends StatefulWidget {
  const ChatAssistant({Key? key}) : super(key: key);

  @override
  State<ChatAssistant> createState() => _ChatAssistantState();
}

class _ChatAssistantState extends State<ChatAssistant> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [
    {
      "role": "system",
      "content":
      " Hey, I'm your bilingual assistant! I will help you better understand the lesson"
    }
  ];
  bool _isSending = false;

  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add({"role": "user", "content": message});
      _isSending = true;
    });

    _controller.clear();
    await Future.delayed(Duration(milliseconds: 100));
    _scrollToBottom();

    final apiKey = dotenv.env['OPENAI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      setState(() {
        _messages.add({
          "role": "assistant",
          "content": "Error: API key not found. Please check your .env file."
        });
        _isSending = false;
      });
      _scrollToBottom();
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": _messages,
          "temperature": 0.7,
        }),
      );

      final data = jsonDecode(response.body);
      final reply = data["choices"][0]["message"]["content"];

      setState(() {
        _messages.add({"role": "assistant", "content": reply});
        _isSending = false;
      });

      await Future.delayed(Duration(milliseconds: 100));
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "assistant",
          "content": "Oops! Something went wrong. Please try again."
        });
        _isSending = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void openChatPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        builder: (_, scrollController) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "Bilingual Buddy 👋",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isUser = msg['role'] == 'user';
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: isUser
                              ? Colors.lightBlue[100]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(msg['content'] ?? ""),
                      ),
                    );
                  },
                ),
              ),
              if (_isSending)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CircularProgressIndicator(),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (_) => setState(() {}),
                      decoration:
                      InputDecoration(hintText: "Ask me anything..."),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _controller.text.trim().isEmpty
                        ? null
                        : () => sendMessage(_controller.text.trim()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: 24,
      child: FloatingActionButton(
        onPressed: () => openChatPanel(context),
        child: Icon(Icons.chat),
        tooltip: "Ask Bilingual Buddy!",
      ),
    );
  }
}
