import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    if (note == '') {
      setState(() {
        _textEditingController.text = AppLocalizations.of(context)!.dbHintNotes;
    });} else {
    setState(() {
      _textEditingController.text = note;
    });
  }}

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
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03,),
      child: TextField(
        style: Theme.of(context).textTheme.bodyMedium,
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
