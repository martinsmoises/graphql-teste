class ContinentScheme {
  String name;

  static ContinentScheme fromJson(Map<String, dynamic> json) {
    ContinentScheme continent = ContinentScheme();
    continent.name = json['name'];
    return continent;
  }
}
