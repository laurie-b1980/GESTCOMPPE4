import 'package:flutter/material.dart';

class RechercherItem extends SearchDelegate {
  final List<String> listExample;
  RechercherItem(this.listExample);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  String selectResult;
  @override
  Widget buildResults(BuildContext context) {
    return Container(child: Center(child: Text('$selectResult')));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    if (query.isNotEmpty) {
      suggestionList
          .addAll(listExample.where((element) => element.contains(query)));
    }
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index]),
            onTap: () {
              selectResult = suggestionList[index];
              showResults(context);
            },
          );
        });
  }
}
