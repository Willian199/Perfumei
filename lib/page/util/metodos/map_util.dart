class MapUtil {
  static String mapToQueryString(Map<dynamic, dynamic> map) {
    final List<String> parts = [];

    map.forEach((key, value) {
      parts.add('$key=$value');
    });

    return parts.join('&');
  }
}
