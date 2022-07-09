abstract class MarkDownElement {}

class Paragraphs extends MarkDownElement {
  late List<MarkDownElement> children;
}

class Heading extends MarkDownElement {
  int level;
  String text;

  Heading(this.level, this.text);
}

enum EmphasisType { bold, italic, boldAndItalic }

class Emphasis extends MarkDownElement {
  late EmphasisType type;

  Emphasis(this.type);
}

class UnParsed extends MarkDownElement {
  String text = "";

  UnParsed(this.text);
}
