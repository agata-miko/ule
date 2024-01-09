import 'package:flutter/material.dart';

class PercentageSlider extends StatefulWidget {
  @override
  _PercentageSliderState createState() => _PercentageSliderState();
}

class _PercentageSliderState extends State<PercentageSlider> {
  double _selectedPercentage = 50; // Initial percentage value

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${_selectedPercentage.round()}%',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Slider(
          value: _selectedPercentage,
          onChanged: (value) {
            setState(() {
              _selectedPercentage = value;
            });
          },
          min: 0,
          max: 100,
          divisions: 100,
          label: '${_selectedPercentage.round()}%',
        ),
      ],
    );
  }
}