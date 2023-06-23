import 'package:flutter/material.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    super.key,
    required this.title,
    this.height,
    required this.maintitle,
  });

  final String title;
  final double? height;
  final String maintitle;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(maintitle),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey.withOpacity(.5),
            width: size.width,
            height: height ?? 50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 17),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
