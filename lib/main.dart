import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:graphql_test/Schems/country_scheme.dart';
import 'package:graphql_test/logic/countries_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountriesBoc _bloc;
  @override
  void initState() {
    _bloc = CountriesBoc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: _buildConteudo(),
        ),
      ),
    );
  }

  Widget _buildConteudo() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _navBar(),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StreamBuilder<List<CountryScheme>>(
                stream: _bloc.listaCountres,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text(
                        'Country not found',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCard(snapshot.data[index].name,
                          snapshot.data[index].emoji);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Row(
            children: <Widget>[
              Text(
                emoji,
                style: TextStyle(fontSize: 50),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
              BorderSide(color: Colors.grey.withOpacity(0.3))),
        ),
      ),
    );
  }

  Widget _navBar() {
    return StreamBuilder<bool>(
        stream: _bloc.searchOn,
        initialData: false,
        builder: (context, snapshot) {
          return Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: snapshot.data
                    ? _textField()
                    : Center(
                        child: Text(
                          'Countries',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
              ),
              Positioned(
                top: snapshot.data ? 20 : 8,
                right: 8,
                child: snapshot.data
                    ? InkWell(
                        onTap: () {
                          _bloc.disableSearch();
                        },
                        child: Text(
                          'cancel',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : IconButton(
                        icon: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _bloc.enableSearch();
                        }),
              )
            ],
          );
        });
  }

  Widget _textField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 60, left: 10),
      child: Container(
        child: TextFormField(
          controller: _bloc.searchController,
          textInputAction: TextInputAction.search,
          maxLength: 2,
          onFieldSubmitted: (value) {
            _bloc.perquisar();
          },
          onSaved: (value) {
            _bloc.perquisar();
          },
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            hintText: 'Type the code of country *BR* *US*',
            contentPadding:
                EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            filled: true,
            fillColor: Colors.white24,
            prefixIcon: IconButton(
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  _bloc.perquisar();
                }),
            border: _outlineInputBorder(),
            disabledBorder: _outlineInputBorder(),
            enabledBorder: _outlineInputBorder(),
            focusedBorder: _outlineInputBorder(),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }
}
