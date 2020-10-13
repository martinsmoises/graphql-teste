class CountryScheme {
  String code;
  String name;
  String nativo;
  String phone;
  String capital;
  String currency;
  String emoji;

  static CountryScheme fromJson(Map<String, dynamic> json) {
    final String entidade = 'country';
    CountryScheme country;

    if (json[entidade] != null) {
      country = CountryScheme();
      if (json[entidade]['code'] != null) {
        country.code = json[entidade]['code'];
      }
      if (json[entidade]['name'] != null) {
        country.name = json[entidade]['name'];
      }
      if (json[entidade]['native'] != null) {
        country.nativo = json[entidade]['native'];
      }
      if (json[entidade]['phone'] != null) {
        country.phone = json[entidade]['phone'];
      }
      if (json[entidade]['capital'] != null) {
        country.capital = json[entidade]['capital'];
      }

      if (json[entidade]['currency'] != null) {
        country.currency = json[entidade]['currency'];
      }
      if (json[entidade]['emoji'] != null) {
        country.emoji = json[entidade]['emoji'];
      }
    }

    return country;
  }

  static CountryScheme fromList(Map<String, dynamic> json) {
    CountryScheme country = CountryScheme();
    country.code = json['code'];
    country.name = json['name'];
    country.nativo = json['native'];
    country.phone = json['phone'];
    country.capital = json['capital'];
    country.currency = json['currency'];
    country.emoji = json['emoji'];

    return country;
  }
}
