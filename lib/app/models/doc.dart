import 'package:equatable/equatable.dart';

class Doc extends Equatable {
  const Doc({required this.title, required this.content});

  final String title;
  final String content;

  @override
  List<Object> get props => [title, content];
}
