import 'package:common/common.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../files/view/file_dialogs.dart';
import '../../locale/locale.dart';
import '../../widgets/model/file.dart';
import '../bloc/notes_bloc.dart';

class NotesList extends StatelessWidget {
  const NotesList(this.files, this.notesBloc, {super.key, this.onNoteTap});

  final List<File> files;
  final void Function(File)? onNoteTap;
  final NotesBloc notesBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing: 8,
        runSpacing: 8,
        children: _notes(context),
      ),
    );
  }

  List<Widget> _notes(BuildContext context) {
    return files.map((file) {
      return _noteInfo(context, file);
    }).toList();
  }

  Widget _noteInfo(BuildContext context, File file) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    return GestureDetector(
      onTap: () => onNoteTap?.call(file),
      child: Card(
        elevation: 4,
        child: IntrinsicHeight(
          child: FlipCard(
            key: cardKey,
            front: _infoCard(context, file, cardKey),
            back: _opsCard(context, file, cardKey),
            flipOnTouch: false,
          ),
        ),
      ),
    );
  }

  Widget _infoCard(BuildContext context, File file, GlobalKey<FlipCardState> controller) {
    IconData icon = Icons.sticky_note_2_outlined;
    if (file.isFolder) {
      icon = Icons.snippet_folder_outlined;
    }
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 8, left: 20, right: 20),
              child: Icon(icon, size: 80),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: SizedBox(
                width: 120,
                child: Text(
                  file.label,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            controller.currentState?.toggleCard();
          },
          icon: const Icon(
            Icons.edit_note_rounded,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _opsCard(BuildContext context, File file, GlobalKey<FlipCardState> controller) {
    List<Widget> ops;
    if (file.isFolder) {
      ops = _notebookOps(context, file, controller);
    } else {
      ops = _noteOps(context, file, controller);
    }
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 128,
          height: 136,
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 2,
            runSpacing: 2,
            children: ops,
          ),
        ),
        IconButton(
          onPressed: () {
            controller.currentState?.toggleCard();
          },
          icon: const Icon(
            Icons.keyboard_return_rounded,
            size: 20,
          ),
        ),
      ],
    );
  }

  List<Widget> _noteOps(BuildContext context, File file, GlobalKey<FlipCardState> controller) {
    return [
      _opButton(
        Icons.remove_red_eye_outlined,
        S.of(context).view,
        () => Routes.open(Routes.routeEditor, args: file.id),
      ),
      _opButton(
        Icons.edit_outlined,
        S.of(context).rename,
        () async {
          await FileDialogs.renameNote(context, file.label, (name) {
            notesBloc.add(RenameNote(file.id ?? '', name));
          });
        },
      ),
      _opButton(
        Icons.delete_outline_rounded,
        S.of(context).delete,
        () async {
          await FileDialogs.deleteFile(context, file.label, () {
            notesBloc.add(DeleteNote(file.id ?? ''));
          });
        },
      ),
      _opButton(
        Icons.drive_file_move_outlined,
        S.of(context).moveTo,
        () async {
          controller.currentState?.toggleCard();
          _openPicker(file.id, file.isFolder);
        },
      ),
    ];
  }

  List<Widget> _notebookOps(BuildContext context, File file, GlobalKey<FlipCardState> controller) {
    return [
      _opButton(
        Icons.remove_red_eye_outlined,
        S.of(context).view,
        () => context.read<NotesBloc>().add(LoadNotes(file.id)),
      ),
      _opButton(
        Icons.edit_outlined,
        S.of(context).rename,
        () async {
          await FileDialogs.renameNotebook(context, file.label, (name) {
            notesBloc.add(RenameNotebook(file.id ?? '', name));
          });
        },
      ),
      _opButton(
        Icons.delete_outline_rounded,
        S.of(context).delete,
        () async {
          await FileDialogs.deleteFile(context, file.label, () {
            notesBloc.add(DeleteNotebook(file.id ?? ''));
          });
        },
      ),
      _opButton(
        Icons.drive_file_move_outlined,
        S.of(context).moveTo,
        () async {
          controller.currentState?.toggleCard();
          _openPicker(file.id, file.isFolder);
        },
      ),
    ];
  }

  void _openPicker(String? id, bool isFolder) async {
    if (id != null && id.isNotEmpty == true) {
      String newParent = await Routes.add(Routes.routePicker, args: id) ?? '';
      Log.d('Picked $newParent for $id');
      if (isFolder) {
        notesBloc.add(MoveNotebook(id, newParent));
      } else {
        notesBloc.add(MoveNote(id, newParent));
      }
    }
  }

  Widget _opButton(IconData icon, String label, void Function()? onPressed) {
    return SizedBox(
      width: 52,
      height: 52,
      child: IconButton(
        onPressed: onPressed,
        tooltip: label,
        icon: Icon(
          icon,
          size: 36,
        ),
      ),
    );
  }
}
