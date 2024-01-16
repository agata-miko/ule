import 'package:flutter/material.dart';

class PercentageSlider extends StatefulWidget {
  final double selectedPercentage;
  final ValueChanged<double>? onChanged;

  const PercentageSlider({Key? key, required this.selectedPercentage, this.onChanged})
      : super(key: key);

  @override
  PercentageSliderState createState() => PercentageSliderState();
}

class PercentageSliderState extends State<PercentageSlider> {
  double _selectedPercentage = 0;

  @override
  void initState() {
    super.initState();
    _selectedPercentage = widget.selectedPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${_selectedPercentage.round()}%',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SliderTheme(
          data: const SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
            trackHeight: 1,
          ),
          child: Slider(
            value: _selectedPercentage,
            onChanged: (value) {
              setState(() {
                _selectedPercentage = value;
              });
              widget.onChanged?.call(value);
            },
            min: 0,
            max: 100,
            divisions: 100,
          ),
        ),
      ],
    );
  }
}
