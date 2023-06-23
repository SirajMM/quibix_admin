import 'package:admin/constants/constants.dart';
import 'package:admin/presentation/home/widgets/product_details.dart';
import 'package:flutter/material.dart';

class ProductsTiles extends StatelessWidget {
  const ProductsTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductDetailsScreen(),
                    ));
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                              items[index]['image']!,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        items[index]['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete confirmation'),
                              content: const Text(
                                  'Are you sure you want to delete this item?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: kTextBlackColor),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: kTextBlackColor),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ),
            ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 0,
            ),
        itemCount: items.length);
  }
}

List<Map<String, String>> items = [
  {'name': 'Headphones', 'image': 'assets/images/headphones.jpg'},
  {'name': 'Tv', 'image': 'assets/images/gconnect1.jpg'},
  {'name': 'Watch', 'image': 'assets/images/image1.png'},
  {'name': 'Laptop', 'image': 'assets/images/images.jpg'},
  {'name': 'Phone', 'image': 'assets/images/08_Galaxy-S23-Ultra_Cream.webp'},
];
