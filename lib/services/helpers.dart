class Helpers {
  static List<T> intersection<T>(Iterable<Iterable<T>> iterables) {
    return iterables
        .map((e) => e.toSet())
        .reduce((a, b) => a.intersection(b))
        .toList();
  }

  static findById(list, String id) {
    // ignore: prefer_function_declarations_over_variables
    Function findById = (obj) => obj.id == id;
    var result = list.where(findById);
    return result.length > 0 ? result.first : null;
  }
}
