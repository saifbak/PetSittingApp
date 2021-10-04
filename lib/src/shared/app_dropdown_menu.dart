import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownDemoState createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDown> {
  var _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DropDown'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          child: DropdownButton<String>(
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),

            items: <String>[
              'Android',
              'IOS',
              'Flutter',
              'Node',
              'Java',
              'Python',
              'PHP',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "Please choose a langauage",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (value) => {
              setState(() {
                _chosenValue = value!;
              })
            },
          ),
        ),
      ),
    );
  }
}
