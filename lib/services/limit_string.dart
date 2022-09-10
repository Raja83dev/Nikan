extension LimitString on String {
  String limited(int maxChar) {
    if (this.length >= maxChar) {
      return this.substring(0, maxChar - 1) + "...";
    }
    return this;
  }
  // ···
}
