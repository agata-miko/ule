import 'package:flutter/material.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({super.key, required this.initialValue});

  final String initialValue;

  @override
  NoteEditorState createState() => NoteEditorState();
}

class NoteEditorState extends State<NoteEditor> {
  late TextEditingController _textEditingController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _textEditingController,
        maxLines: null,
        decoration: const InputDecoration(
          hintText: 'Notatki',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

