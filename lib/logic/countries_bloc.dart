import 'package:flutter/material.dart';
import 'package:graphql_test/schems/country_scheme.dart';
import 'package:graphql_test/services/service_countries.dart';
import 'package:rxdart/rxdart.dart';

class CountriesBoc {
  BuildContext context;
  ServiceCountries _serviceCountries;
  final _listCountries = BehaviorSubject<List<CountryScheme>>();
  final _enableSearch = BehaviorSubject<bool>.seeded(false);
  TextEditingController searchController = TextEditingController();
  Stream get listaCountres => _listCountries.stream;
  Stream get searchOn => _enableSearch.stream;

  CountriesBoc(this.context) {
    _serviceCountries = ServiceCountries();
    _getAllCountries();
  }

  void dispose() {
    _listCountries.close();
    _enableSearch.close();
  }

  void _getAllCountries() async {
    await _serviceCountries.getAllCountries().then((value) {
      if (value != null) {
        _listCountries.sink.add(value.listCountrys);
      }
    });
  }

  void perquisar() async {
    String code = searchController.text.toUpperCase();
    await _serviceCountries.getCountryByCode(code).then((value) {
      if (value != null) {
        List<CountryScheme> list = List();
        list.add(value);
        _listCountries.sink.add(null);
        _listCountries.sink.add(list);
      } else {
        _listCountries.sink.add([]);
      }
    });
  }

  void enableSearch() {
    _enableSearch.add(true);
  }

  void disableSearch() {
    searchController.text = '';
    if (_listCountries.value.length < 2) {
      _listCountries.sink.add(null);
    }
    _getAllCountries();
    _enableSearch.add(false);
  }
}
