import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../../design/theme.dart';
import '../../home/bloc/working_cubit.dart';
import '../../l10n/wording.dart';
import '../../widgets/app_bar.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late NoteRepository _noteRepository;

  @override
  void initState() {
    super.initState();
    _noteRepository = RepositoryProvider.of<NoteRepository>(context);
  }

  void _addNote() async {
    String? parentId = context.read<WorkingCubit>().state.notebookId;
    if (parentId != null && parentId.isNotEmpty == true) {
      String noteId = await _noteRepository.addNote(parentId, '', '');
      Log.d('Add note $noteId');
      if (noteId.isNotEmpty) {
        Routes.open(Routes.routeEditor, args: noteId);
      }
    }
  }

  void _openDrawer() {
    context.read<AppDrawerCubit>().openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkingCubit, WorkingState>(
      builder: (context, state) {
        bool canAddNote = state.notebookId?.isNotEmpty == true;
        return Scaffold(
          appBar: AppBarBuilder.withDrawer(
            context,
            S.of(context).home,
            _openDrawer,
            const [],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _welcomeMessage(context, canAddNote),
            ),
          ),
          floatingActionButton: _floatingActionButton(context, canAddNote),
        );
      },
    );
  }

  List<Widget> _welcomeMessage(BuildContext context, bool canAddNote) {
    if (!canAddNote) {
      return <Widget>[
        Text(
          S.of(context).hello(S.of(context).appName),
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(20),
        ),
        Text(
          S.of(context).addNotebookHint,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ];
    } else {
      return <Widget>[
        Text(
          S.of(context).hello(S.of(context).appName),
          style: Theme.of(context).textTheme.headline2,
        ),
      ];
    }
  }

  Widget? _floatingActionButton(BuildContext context, bool canAddNote) {
    if (canAddNote) {
      return FloatingActionButton(
        onPressed: _addNote,
        tooltip: S.of(context).addNote,
        child: const Icon(Icons.add),
      );
    } else {
      return null;
    }
  }
}
