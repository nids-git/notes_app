import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget{

  @override
  State<Demo> createState() => _DemoState();

}

class _DemoState extends State<Demo>{
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
          child: Scaffold(
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: _topSection(),
                  ),
                  TabBar(
                    isScrollable: true,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      tabs: [
                    Tab(text: 'Yes',),
                    Tab(text:'No')
                  ]),
                  Expanded(
                      child: TabBarView(
                          children: [
                            Column(
                              children: [
                                Text('First Tab'),
                      Center(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black
                              )
                            )
                          ),
                          hint: Text('Please choose a location'), // Not necessary for Option 1
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLocation = newValue!;
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      )
                              ],
                            ),
                            Column(
                              children: [
                                Text('Second Tab')
                              ],
                            )
                          ]))
                ],
              ),
            )
          )),
    );
  }

   _topSection(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_right_alt_rounded),
          Text('My DemoScreen', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
          ),
          Text('Skip', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14
          ),
          )
        ]
    );
  }
}