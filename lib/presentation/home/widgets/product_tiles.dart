import 'package:admin/constants/constants.dart';
import 'package:admin/presentation/product_details/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
              physics: const BouncingScrollPhysics(),
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
                    height: 100,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          height: 80,
                          width: 80,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                          imageUrl: details['imageList'] == null ||
                                  details['imageList'].length == 0
                              ? ''
                              : details['imageList'][0],
                          placeholder: (context, url) =>
                              Image.asset('assets/images/loadinganimation.gif'),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
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
