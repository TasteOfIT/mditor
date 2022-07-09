import 'package:markdown/markdown.dart';
import 'package:markdown_parser/element/element.dart';

extension NodeExtensions on Node {
  MarkDownElement convertToMarkDownElement() {
    MarkDownElement? result;
    if (this is Element) {
      result = convertElement(this as Element);
    } else {
      result = UnParsed(textContent);
    }
    return result ?? UnParsed("");
  }
}

final _headingPattern = RegExp("h[1-6]");

MarkDownElement? convertElement(Element element) {
  MarkDownElement? result;
  if (_headingPattern.hasMatch(element.tag)) {
    result =
        Heading(int.parse(element.tag.substring(1, 2)), element.textContent);
  }
  return result;
}
