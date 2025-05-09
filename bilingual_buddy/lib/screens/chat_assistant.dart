import 'dart:convert';
import 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Floating chat button + bottom-sheet assistant.
/// Add `const ChatAssistant()` to any screen where chat is allowed.
class ChatAssistant extends StatefulWidget {
  const ChatAssistant({Key? key}) : super(key: key);

  @override
  State<ChatAssistant> createState() => _ChatAssistantState();
}

class _ChatAssistantState extends State<ChatAssistant> {
  final TextEditingController _controller = TextEditingController();

  /// Conversation history sent to OpenAI.
  final List<Map<String, String>> _messages = [
    {
      'role': 'system',
      'content': '''
You are “Bilingual Buddy”, a warm, enthusiastic English tutor for Spanish-speaking kids.
• Answer in 2–3 friendly sentences (≈40–60 words total).
• When math appears, show step-by-step reasoning in simple words.
• Add a fun emoji when it feels natural.'''
    }
  ];
  bool _isSending = false;

  // ────────────────────────────────────────── helpers ─────────────────────────
  String _apiKey() {
    if (kIsWeb) {
      final dyn = js.context['env'];
      if (dyn != null && dyn['OPENAI_API_KEY'] != null) {
        return dyn['OPENAI_API_KEY'] as String;
      }
    }
    return dotenv.env['OPENAI_API_KEY'] ?? '';
  }

  Future<String?> _fetchReply() async {
    final resp = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_apiKey()}',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'temperature': 0.85, // a bit more creative
        'messages': _messages,
      }),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      return data['choices'][0]['message']['content'] as String;
    }
    return null;
  }

  // ───────────────────────────── bottom-sheet launcher ────────────────────────
  void _openSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => StatefulBuilder(
        builder: (context, setSheet) {
          final visible =
          _messages.where((m) => m['role'] != 'system').toList();
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text('Bilingual Buddy 👋',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: visible.length,
                    itemBuilder: (_, i) {
                      final msg = visible[visible.length - 1 - i];
                      final isUser = msg['role'] == 'user';
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          constraints: BoxConstraints(
                              maxWidth:
                              MediaQuery.of(context).size.width * 0.75),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Colors.lightBlue[100]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(msg['content'] ?? ''),
                        ),
                      );
                    },
                  ),
                ),
                if (_isSending) const CircularProgressIndicator(),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                            hintText: 'Ask me anything…'),
                        onChanged: (_) =>
                            setSheet(() {}), // refresh arrow on typing
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _controller.text.trim().isEmpty
                          ? null
                          : () async {
                        final text = _controller.text.trim();
                        _controller.clear();

                        // → add user bubble
                        setState(() {
                          _messages
                              .add({'role': 'user', 'content': text});
                          _isSending = true;
                        });
                        setSheet(() {});

                        // → assistant reply
                        final reply = await _fetchReply() ??
                            'Lo siento, I could not answer right now 😔';
                        setState(() {
                          _messages.add(
                              {'role': 'assistant', 'content': reply});
                          _isSending = false;
                        });
                        setSheet(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ────────────────────────────────── lifecycle ───────────────────────────────
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ────────────────────────────────── UI entry ────────────────────────────────
  @override
  Widget build(BuildContext context) => Positioned(
    bottom: 24,
    right: 24,
    child: FloatingActionButton(
      onPressed: () => _openSheet(context),
      tooltip: 'Ask Bilingual Buddy!',
      child: const Icon(Icons.chat),
    ),
  );
}
