import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownExample extends StatefulWidget {
  final List<String>? items; // List of items

  const DropdownExample({
    Key? key,
    required this.items
  }) : super(key:key);

  @override
  _DropdownExampleState createState() => _DropdownExampleState();

}
class _DropdownExampleState extends State<DropdownExample> {
  String? selectedValue; // Variable to hold the selected value

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: DropdownButtonHideUnderline(
          child:DropdownButtonFormField<String>(
            value: selectedValue, // Currently selected value
            hint: Text('Select an option'), // Hint text
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0
                    )
                )
            ),
            items: (widget.items)!.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue; // Update the selected value
              });
            },
          ) ),
    );
  }
}