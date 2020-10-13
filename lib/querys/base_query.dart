import 'package:graphql/client.dart';

class BaseQuery {
  HttpLink httpLink;
  GraphQLClient client;
  BaseQuery() {
    httpLink = HttpLink(uri: 'https://countries.trevorblades.com/');
    client = GraphQLClient(cache: InMemoryCache(), link: httpLink);
  }

  Future<dynamic> getData(String query,
      {Map<String, dynamic> variables}) async {
    try {
      QueryOptions options =
          QueryOptions(documentNode: gql(query), variables: variables);
      QueryResult _result = await client.query(options);
      print('Timestamp: ${_result.timestamp}');
      print('Resultado: ${_result.data}');
      return _result.data;
    } catch (e) {
      print('Erro $e');
      return null;
    }
  }
}
