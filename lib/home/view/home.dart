import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app.dart';
import '../../design/theme.dart';
import '../../l10n/wording.dart';
import '../../widgets/view_dialogs.dart';
import '../cubit/file_list_bloc.dart';
import 'file_manager.dart';
import 'side_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FileListBloc fileListBloc;
  late NotebookRepository notebookRepository;

  @override
  void initState() {
    super.initState();
    notebookRepository = Modular.get<NotebookRepository>();
    fileListBloc = FileListBloc(notebookRepository);
    fileListBloc.add(FileListRefresh());
  }

  Future<void> _addNotebook(FileListBloc fileListBloc) async {
    String name = await ViewDialogs.editorDialog(context, S.of(context).addNotebook);
    int result = await notebookRepository.addNotebook(name);
    Log.d('Insert $result');
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotebookRepository>(
          create: (context) => notebookRepository,
        ),
      ],
      child: Scaffold(
        drawer: SideDrawer(
          fileTree: BlocProvider(
            create: (context) => fileListBloc,
            child: const FileManager(),
          ),
          addNotebook: () => _addNotebook(fileListBloc),
          openSettings: () => {},
        ),
        body: _routeContainer(context),
      ),
    );
  }

  Widget _routeContainer(BuildContext context) {
    return BlocProvider(
      create: (context) => AppDrawerCubit(Scaffold.of(context)),
      child: const RouterOutlet(),
    );
  }

  @override
  void dispose() {
    fileListBloc.close();
    super.dispose();
  }
}
