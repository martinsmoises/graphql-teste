class Querys {
  static String getAllCoutries() {
    String query = r"""
  query ReadAllCoutries{
  countries{
    code
    name
    native
    phone
    capital
    currency
    emoji
  }
}
""";
    return query;
  }

  static String getCountryByCode(String code) {
    String query = r"""
  query ReadACoutry($code : ID!){
  country(code: $code){
    code
    name
    native
    phone
    capital
    currency
    emoji
  }
}
""";

    print(query);
    return query;
  }
}
