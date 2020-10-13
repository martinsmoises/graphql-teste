import 'package:graphql_test/Schems/country_scheme.dart';

class CountriesScheme {
  List<CountryScheme> listCountrys;

  CountriesScheme({this.listCountrys});

  static CountriesScheme fromJson(Map<String, dynamic> json) {
    String entidade = 'countries';
    CountriesScheme countries = CountriesScheme();
    countries.listCountrys = List<CountryScheme>();
    json[entidade].forEach((value) {
      countries.listCountrys.add(CountryScheme.fromList(value));
    });
    return countries;
  }
}
