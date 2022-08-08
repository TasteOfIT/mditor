extension BoolExtensions on bool {
  int toInt() {
    if (this) {
      return 1;
    } else {
      return 0;
    }
  }
}

extension IntExtensions on int {
  bool toBool() {
    return this != 0;
  }
}
