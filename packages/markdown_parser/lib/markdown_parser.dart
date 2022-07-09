library markdown_parser;

import 'dart:convert';

import 'package:markdown/markdown.dart';
import 'package:markdown_parser/extensions.dart';

import 'element/element.dart';

class MarkdownParser {
  Document document = Document(
      extensionSet: ExtensionSet.gitHubFlavored,
      blockSyntaxes: ExtensionSet.gitHubFlavored.blockSyntaxes,
      inlineSyntaxes: ExtensionSet.gitHubFlavored.inlineSyntaxes);

  List<MarkDownElement> parse(String content) {
    var elements = <MarkDownElement>[];
    var nodes = document.parseLines(const LineSplitter().convert(content));

    for (Node node in nodes) {
      elements.add(node.convertToMarkDownElement());
    }

    return elements;
  }
}
