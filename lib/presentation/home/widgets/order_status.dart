import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetailsActive extends StatelessWidget {
  const OrderDetailsActive({
    super.key,
    required this.data,
    required this.orderData,
  });
  final DocumentSnapshot<Object?> data;
  final QueryDocumentSnapshot<Map<String, dynamic>> orderData;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: size.width * 0.98,
                  height: size.width * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(.2)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(data['imageList'][0]),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.64,
                            child: Text(
                              data['productname'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: size.width * 0.6,
                            child: Text(
                              data['description'],
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(.5)),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Text(
                            'Silver |  Nos : ${orderData['count']} ',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                          ),
                          Text(
                            'Price :\$ ${orderData['price']}',
                            style: const TextStyle(fontSize: 22),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Total Price :\$ ${orderData['totalPrice']}',
                            style: const TextStyle(fontSize: 22),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
