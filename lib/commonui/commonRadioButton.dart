import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioExample extends StatefulWidget {
  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String? selectedValue; // Variable to store the selected value

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
            title: Text('Option 1'),
            leading: Radio<String>(
              value: 'Option 1',
              groupValue: selectedValue, // Current selected value
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value; // Update the selected value
                });
              },
            ),
          ),
          ListTile(
            title: Text('Option 2'),
            leading: Radio<String>(
              value: 'Option 2',
              groupValue: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Option 3'),
            leading: Radio<String>(
              value: 'Option 3',
              groupValue: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
          ),
        ],
      );
  }
}
