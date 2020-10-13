import 'package:graphql_test/schems/countries_scheme.dart';
import 'package:graphql_test/schems/country_scheme.dart';
import 'package:graphql_test/querys/querys.dart';
import 'package:graphql_test/services/service_base.dart';

class ServiceCountries {
  Future<CountriesScheme> getAllCountries() async {
    ServiceBase<CountriesScheme> _serviceBase = ServiceBase();
    CountriesScheme countries;
    await _serviceBase
        .getElement(Querys.getAllCoutries(), CountriesScheme.fromJson)
        .then((value) {
      if (value != null) {
        countries = value;
      }
    });
    return countries;
  }

  Future<CountryScheme> getCountryByCode(String code) async {
    ServiceBase<CountryScheme> _serviceBase = ServiceBase();
    CountryScheme country;
    Map<String, dynamic> variables = {"code": code};
    await _serviceBase
        .getElement(Querys.getCountryByCode(code), CountryScheme.fromJson,
            variables: variables)
        .then((value) {
      if (value != null) {
        country = value;
      }
    });
    return country;
  }
}
