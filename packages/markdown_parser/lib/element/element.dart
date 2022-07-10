abstract class MarkDownElement {}

class Paragraphs extends MarkDownElement {
  late List<MarkDownElement> children;
}

class Heading extends MarkDownElement {
  int level;
  String text;

  Heading(this.level, this.text);
}

enum EmphasisType { bold, italic, boldAndItalic, code }

class Emphasis extends MarkDownElement {
  EmphasisType type;
  String text;

  Emphasis(this.type, this.text);
}

class Paragraph extends MarkDownElement {
  late List<MarkDownElement> children;
}

class CodeBlock extends MarkDownElement {
  String text;

  CodeBlock(this.text);
}

class UnParsed extends MarkDownElement {
  String text = "";

  UnParsed(this.text);
}
