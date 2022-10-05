import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../design/theme.dart';
import '../bloc/file_list_bloc.dart';
import '../bloc/working_cubit.dart';
import 'file_manager.dart';
import 'side_bar_menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FileListBloc _fileListBloc;
  late WorkingCubit _workingCubit;
  late NotebookRepository _notebookRepository;
  late NoteRepository _noteRepository;

  @override
  void initState() {
    super.initState();
    _notebookRepository = Modular.get<NotebookRepository>();
    _noteRepository = Modular.get<NoteRepository>();
    _workingCubit = WorkingCubit();
    _fileListBloc = FileListBloc(_notebookRepository, _noteRepository);
    _fileListBloc.add(FileListRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotebookRepository>(
          create: (_) => _notebookRepository,
        ),
        RepositoryProvider<NoteRepository>(
          create: (_) => _noteRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _fileListBloc),
          BlocProvider(create: (_) => _workingCubit),
        ],
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
    _workingCubit.close();
    _fileListBloc.close();
    super.dispose();
  }
}
