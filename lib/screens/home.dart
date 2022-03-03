import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';
import './single.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isLoading = false;
  var _recipies = [];

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  Future<void> getAllRecipies() async {
    const String basicUrl =
        'https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=under_30_minutes';
    final url = Uri.parse(basicUrl);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-rapidapi-host': 'tasty.p.rapidapi.com',
          'x-rapidapi-key': '2b7b34d01bmsh2bb90bbaf338c99p12299ejsnd279ad96ad26'
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      setState(() {
        _recipies = responseData['results'];
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllRecipies();
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Material(
          child: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: Text(
                'Recipe App',
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.all(10.0),
                // color: Colors.white,
                child: ListView.builder(
                  itemCount: _recipies.length,
                  itemBuilder: (context, int index) => GestureDetector(
                      onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      SingleRecipe(recipe: _recipies[index])),
                            )
                          },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(7),
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                height: 150,
                                margin: const EdgeInsets.all(0.9),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                  ),
                                  child: Image.network(
                                    _recipies[index]['thumbnail_url'],
                                    height: 145,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      _recipies[index]["name"],
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 26, 37, 24),
                                          fontSize: 20),
                                    ),
                                  ),
                                  Text(_recipies[index]["yields"])
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
