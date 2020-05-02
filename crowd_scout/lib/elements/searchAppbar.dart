import 'package:flutter/material.dart';

AppBar searchAppBar({
  String title = "",
  bool searching = true,
  Function toggleSearch,
  bool autofocus = false,
  @required Function onSearch,
  String defaultSearchString = "",
}) =>
    AppBar(
      title: searching
          ? TextField(
              autofocus: autofocus,
              autocorrect: true,
              controller: TextEditingController(text: defaultSearchString),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                decorationColor: Colors.white,
              ),
              onSubmitted: onSearch,
            )
          : Text(title),
      actions: <Widget>[
        IconButton(
          icon: searching ? Icon(Icons.clear) : Icon(Icons.search),
          tooltip: searching ? "Cancel Search" : "Search",
          onPressed: toggleSearch,
        ),
      ],
    );
