import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  MyCheckbox({super.key});
  String title="";

  @override
  State<MyCheckbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<MyCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      if(isChecked)
        return Colors.blue;
      
      return Colors.white;
    }

    return CheckboxListTile(
      title: Text(""),
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

  bool checked(){
    return isChecked;
  }
}