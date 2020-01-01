import  'package:flutter/material.dart';

InputDecoration textInputDeco (context) => InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0) 
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0) 
  ),
);