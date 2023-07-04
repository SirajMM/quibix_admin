import 'package:admin/constants/constants.dart';
import 'package:admin/presentation/product_details/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ProductsTiles extends StatelessWidget {
  const ProductsTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: products.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.docs;
          return ListView.separated(
              itemBuilder: (context, index) {
                final DocumentSnapshot details = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            details: details,
                          ),
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                                image: NetworkImage(
                                  details['imageList'][0],
                                ),
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            details['productname'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteDialogbox(context, details.id);
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
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 0,
                  ),
              itemCount: data.length);
        }
        return const Center(child: Text('No products found'));
      },
    );
  }

  Future<dynamic> deleteDialogbox(BuildContext context, id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete confirmation'),
          content: const Text('Are you sure you want to delete this item?'),
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
                deleteProduct(id, context);
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
  }

  void deleteProduct(id, context) {
    products.doc(id).delete().then((value) => Navigator.of(context).pop(true));
  }
}

final CollectionReference products =
    FirebaseFirestore.instance.collection('products');
// List<Map<String, String>> items = [
//   {'name': 'Headphones', 'image': 'assets/images/headphones.jpg'},
//   {'name': 'Tv', 'image': 'assets/images/gconnect1.jpg'},
//   {'name': 'Watch', 'image': 'assets/images/image1.png'},
//   {'name': 'Laptop', 'image': 'assets/images/images.jpg'},
//   {'name': 'Phone', 'image': 'assets/images/08_Galaxy-S23-Ultra_Cream.webp'},
// ];
