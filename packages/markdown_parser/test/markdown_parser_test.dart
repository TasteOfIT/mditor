import 'package:flutter_test/flutter_test.dart';
import 'package:markdown_parser/element/element.dart';

import 'package:markdown_parser/markdown_parser.dart';

void main() {
  test('given text `## header`,when parse,then the first element is Heading',
      () {
    MarkdownParser parser = MarkdownParser();
    String text = "## header";

    List<MarkDownElement> elements = parser.parse(text);

    var isHeading = elements.first is Heading;
    expect(isHeading, true);
    expect((elements.first as Heading).level, 2);
    expect((elements.first as Heading).text, "header");
  });
}
