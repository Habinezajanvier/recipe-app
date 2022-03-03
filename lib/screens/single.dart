import 'package:flutter/material.dart';

class SingleRecipe extends StatelessWidget {
  const SingleRecipe({Key? key, required this.recipe}) : super(key: key);
  final Object recipe;
  @override
  Widget build(BuildContext context) {
    final myRecipe = recipe as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(myRecipe['name']),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            child: Image.network(myRecipe['thumbnail_url']),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  myRecipe['name'],
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Descriptions')),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Ingredients',
                        style: const TextStyle(
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text('Nutrion'))
                  ],
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                      itemCount: myRecipe['sections'][0]['components'].length,
                      itemBuilder: (ctx, int index) => Row(
                            children: <Widget>[
                              const Icon(
                                Icons.lunch_dining,
                                size: 16.4,
                                color: Color.fromARGB(255, 40, 46, 29),
                              ),
                              Text(
                                myRecipe['sections'][0]['components'][index]
                                    ['ingredient']['name'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 40, 46, 29),
                                ),
                              ),
                            ],
                          )),
                ),
                Text(myRecipe['yields'])
              ],
            ),
          )
        ],
      ),
    );
  }
}
