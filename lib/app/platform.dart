import 'dart:io' show Platform;

bool isMobile = Platform.isAndroid || Platform.isIOS;
bool isDesktop = Platform.isMacOS || Platform.isLinux || Platform.isWindows;
