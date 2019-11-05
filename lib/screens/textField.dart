import 'package:flutter/material.dart';

class textfiled extends StatelessWidget {
  const textfiled({this.change, this.text, this.obs, this.textInputType});
  final Function change;
  final String text;
  final bool obs;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      obscureText: obs,
      textAlign: TextAlign.center,
      style: TextStyle(color: Color(0xFF212121)),
      onChanged: change,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Colors.blueGrey[400]),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
