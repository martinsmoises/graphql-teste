import 'package:graphql_test/querys/base_query.dart';

class ServiceBase<T> {
  BaseQuery _baseQuery;

  Future<T> getElement(String query, fromJson(Map<String, dynamic> json),
      {Map<String, dynamic> variables}) async {
    _baseQuery = BaseQuery();
    T element;
    await _baseQuery.getData(query, variables: variables).then((value) {
      if (value != null) {
        element = fromJson(value);
      }
    });

    return element;
  }
}
