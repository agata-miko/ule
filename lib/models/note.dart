import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';

class NoteEditor extends ConsumerStatefulWidget {
  const NoteEditor({super.key, required this.hiveId});

  final String hiveId;

  @override
  NoteEditorState createState() => NoteEditorState();
}

class NoteEditorState extends ConsumerState<NoteEditor> {
  late final TextEditingController _textEditingController =
      TextEditingController();

  Future<void> _loadNoteFromTheDatabase() async {
    final String note =
        await ref.read(databaseProvider).getHiveNote(widget.hiveId);
    setState(() {
      _textEditingController.text = note;
    });
  }

  Future<void> _saveNoteToTheDatabase() async {
    final String newNote = _textEditingController.text;
    ref.read(databaseProvider).updateHiveNote(widget.hiveId, newNote);
  }

  @override
  void initState() {
    super.initState();
    _loadNoteFromTheDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        maxLines: null,
        controller: _textEditingController,
        textAlign: TextAlign.justify,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (String value) {
          _saveNoteToTheDatabase();
        },
      ),
    );
  }
}
