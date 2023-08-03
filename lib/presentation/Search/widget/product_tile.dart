import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/constants.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(data['imageList'][0]),
                  fit: BoxFit.contain,
                )),
            child: Stack(
              children: [
                Positioned(
                    left: 125,
                    top: 0,
                    child: IconButton(
                      icon: const Icon(
                        CupertinoIcons.heart_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {},
                    ))
              ],
            ),
          ),
          khieght10,
          Text(
            data['productname'],
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  letterSpacing: .5,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
          ),
          khieght5,
          Text(
            data['subname'],
            maxLines: 2,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  letterSpacing: .5,
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
          ),
          khieght5,
          Text(
            '\$ ${data['price']}',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  letterSpacing: .5,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
