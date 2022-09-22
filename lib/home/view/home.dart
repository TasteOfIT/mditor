import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../design/theme.dart';
import '../bloc/file_list_bloc.dart';
import 'file_manager.dart';
import 'side_bar_menu.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotebookRepository>(
          create: (context) => notebookRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => fileListBloc,
        child: _mainContent(context),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: SideBarMenu(
          fileTree: FileManager(),
        ),
      ),
      body: BlocProvider(
        create: (context) => AppDrawerCubit(Scaffold.of(context)),
        child: const RouterOutlet(),
      ),
    );
  }

  @override
  void dispose() {
    fileListBloc.close();
    super.dispose();
  }
}
