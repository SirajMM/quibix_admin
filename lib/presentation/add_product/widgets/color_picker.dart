import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key, required this.slectedColors});
  final List<Color> slectedColors;
  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  void changeColor(Color color) {
    setState(() {
      widget.slectedColors.add(color);
    });
  }

  void removeColor(Color color) {
    setState(() {
      widget.slectedColors.remove(color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Select Colors'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: Colors.white,
                      availableColors: primaryColorsList(),
                      onColorChanged: (Color color) {
                        changeColor(color);
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Open Color Picker'),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: widget.slectedColors.map((Color color) {
            return Chip(
              backgroundColor: color,
              label: Text(
                color.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              onDeleted: () {
                removeColor(color);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  List<Color> primaryColorsList() {
    return Colors.primaries.map((ColorSwatch color) => color).toList();
  }
}
