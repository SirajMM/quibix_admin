import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ColorPallet extends StatefulWidget {
  const ColorPallet({
    super.key,
    required this.details,
    required this.colorList,
    required this.editOrNot,
  });

  final DocumentSnapshot<Object?> details;
  final List colorList;
  final bool editOrNot;

  @override
  State<ColorPallet> createState() => _ColorPalletState();
}

class _ColorPalletState extends State<ColorPallet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        height: 30,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.colorList.length,
          itemBuilder: (context, index) => widget.editOrNot
              ? Container(
                  height: 25,
                  width: 25,
                  color: Color(
                    int.parse(widget.colorList[index]),
                  ),
                )
              : Chip(
                  backgroundColor: Color(int.parse(widget.colorList[index])),
                  label: Text(
                    widget.colorList[index].toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  onDeleted: () {
                    widget.colorList.removeAt(index);
                    setState(() {});
                  },
                ),
          separatorBuilder: (context, index) => const SizedBox(
            width: 20,
          ),
        ),
      ),
    );
  }
}
