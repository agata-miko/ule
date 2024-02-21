import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PercentageSlider extends StatefulWidget {
  final double selectedPercentage;
  final ValueChanged<double>? onChanged;

  const PercentageSlider(
      {Key? key, required this.selectedPercentage, this.onChanged})
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
          AppLocalizations.of(context)!.sliderPercentage(_selectedPercentage.round().toStringAsFixed(0)),
          style: const TextStyle(fontSize: 16),
        ),
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: Color(0xFF233406),
            activeTrackColor: Color(0xFF233406),
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
