import 'package:flutter/material.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({super.key});

  @override
  NoteEditorState createState() => NoteEditorState();
}

class NoteEditorState extends State<NoteEditor> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _textEditingController,
        maxLines: null, // Allows for multiline input
        decoration: const InputDecoration(
          hintText: 'Notatki',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

