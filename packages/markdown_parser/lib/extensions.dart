import 'package:markdown/markdown.dart';
import 'package:markdown_parser/element/element.dart';

extension NodeExtensions on Node {
  MarkDownElement convertToMarkDownElement() {
    MarkDownElement? result;
    if (this is Element) {
      result = _convertElement(this as Element);
    } else {
      result = UnParsed(textContent);
    }
    return result ?? UnParsed("");
  }
}

final _headingPattern = RegExp("h[1-6]");

MarkDownElement? _convertElement(Element element) {
  MarkDownElement? result;
  //header
  if (_headingPattern.hasMatch(element.tag)) {
    result =
        Heading(int.parse(element.tag.substring(1, 2)), element.textContent);
  }

  //paragraph
  if (element.tag == 'p') {
    var paragraph = Paragraph();
    paragraph.children = [];
    var children = element.children;
    if (children != null) {
      for (var node in children) {
        if (node is Text) {
          paragraph.children.add(UnParsed(node.text));
        }
        if (node is Element) {
          _convertEmphasis(node, paragraph);
        }
      }
    }
    result = paragraph;
  }
  return result;
}

void _convertEmphasis(Element node, Paragraph paragraph) {
  var childText = node.children?.first.textContent;
  switch (node.tag) {
    case "strong":
      paragraph.children.add(Emphasis(EmphasisType.bold, childText ?? ""));
      break;
    case "em":
      if (node.children?.first is Text) {
        paragraph.children.add(Emphasis(EmphasisType.italic, childText ?? ""));
      }
  }
}
