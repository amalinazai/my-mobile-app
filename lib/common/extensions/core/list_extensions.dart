extension ListExtensions<T> on List<T> {
  List<T> combineWith(List<T> other) {
    final result = <T>[...this, ...other];
    return result;
  }
}
