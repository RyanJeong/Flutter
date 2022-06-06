import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

void main() async {
  var document = parse('<!DOCTYPE html><html><body><h1>A Hidden Field (look in source code)</h1> <form action="/action_page.php"> <label for="fname">First name:</label> <input type="text" id="fname" name="fname"><br><br> <input type="hidden" id="custId" name="custId" value="3487"> <input type="submit" value="Submit"></form><p><strong>Note:</strong> The hidden field is not shown to the user, but the data is sent when the form is submitted.</p></body></html>');
  print(document.outerHtml);
  var elements = document.getElementById('custId')?.attributes['value'];
  // 3487
  print(elements);

  /// var url = Uri.parse('https://www.w3schools.com/tags/tryit.asp?filename=tryhtml5_input_type_hidden');
  /// var response = await http.Client().get(url);

  /// if (response.statusCode == 200) {
  ///   var document = parse(response.body);
  ///   var elements = document.getElementById('custId');
  ///   print(elements?.text);
  /// } else {
  ///   throw Exception();
  /// }
}