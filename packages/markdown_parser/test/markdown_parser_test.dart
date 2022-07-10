import 'package:flutter_test/flutter_test.dart';
import 'package:markdown_parser/element/element.dart';

import 'package:markdown_parser/markdown_parser.dart';

void main() {
  var parser = MarkdownParser();

  test('given text `## header`,when parse,then the first element is Heading',
      () {
    String text = "## header";

    var elements = parser.parse(text);

    var isHeading = elements.first is Heading;
    expect(isHeading, true);
    expect((elements.first as Heading).level, 2);
    expect((elements.first as Heading).text, "header");
  });

  test(
      "given text `**text**`,when parse, then the first element is Paragraph and its first child is `bold`",
      () {
    String text = "**text**";

    List<MarkDownElement> elements = parser.parse(text);

    var isParagraph = elements.first is Paragraph;
    expect(isParagraph, true);
    var firstChild = (elements.first as Paragraph).children.first;
    var isEmphasis = firstChild is Emphasis;
    expect(isEmphasis, true);
    expect((firstChild as Emphasis).type, EmphasisType.bold);
    expect(firstChild.text, 'text');
  });

  test(
      "given text `*text*`,when parse, then the first element is Paragraph and its first child is `bold`",
      () {
    String text = "*text*";

    var elements = parser.parse(text);

    var isParagraph = elements.first is Paragraph;
    expect(isParagraph, true);
    var firstChild = (elements.first as Paragraph).children.first;
    var isEmphasis = firstChild is Emphasis;
    expect(isEmphasis, true);
    expect((firstChild as Emphasis).type, EmphasisType.italic);
    expect(firstChild.text, 'text');
  });

  test(
      "given text ``text``,when parse, then the first element is Paragraph and its first child is `code`",
      () {
    String text = "`text`";

    var elements = parser.parse(text);

    var isParagraph = elements.first is Paragraph;
    expect(isParagraph, true);
    var firstChild = (elements.first as Paragraph).children.first;
    var isEmphasis = firstChild is Emphasis;
    expect(isEmphasis, true);
    expect((firstChild as Emphasis).type, EmphasisType.code);
    expect(firstChild.text, 'text');
  });

  test(
      "given text with ``` and line space,when parse, then the first element is CodeBlock",
      () {
    String text = "``` \ntext\n ```";

    var elements = parser.parse(text);

    var isCodeBlock = elements.first is CodeBlock;
    expect(isCodeBlock, true);
    expect((elements.first as CodeBlock).text, 'text\n');
  });
}
