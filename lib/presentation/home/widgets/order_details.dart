// ignore_for_file: must_be_immutable
import 'package:admin/application/orders/order_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_details_tile.dart';
import 'order_status.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    super.key,
    required this.data,
  });
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<String> nameList = <String>[
    'Placed',
    'Shipped',
    'Out of Delivery',
    'Delivered'
  ];
  late DocumentSnapshot<Object?> data;
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false)
        .getProductData(widget.data['cartList'])
        .listen((DocumentSnapshot data) {
      setState(() {
        this.data = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownNameValue = widget.data['status'];
    Timestamp timestamp = widget.data['orderDate'];
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          const DetailsTile(title: 'user@gmail.com', maintitle: 'Email'),
          const DetailsTile(
              height: 110,
              title: '${'User\n'}${'Kochi\n'}${'Alappatt (H)'}',
              maintitle: 'Adress'),
          DetailsTile(title: formattedDate, maintitle: 'Ordered on'),
          const DetailsTile(title: 'RazorPay', maintitle: 'Payment Method'),
          DetailsTile(title: data['category'], maintitle: 'Category'),
          OrderDetailsActive(data: data, orderData: widget.data),
          StatefulBuilder(
            builder: (context, setState) => DropdownButtonHideUnderline(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: DropdownButton<String>(
                    value: dropdownNameValue,
                    icon: const Icon(Icons.arrow_downward_sharp),
                    elevation: 8,
                    style: const TextStyle(color: Colors.black),
                    disabledHint: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? value) {
                      setState(
                        () {
                          final orderRef = FirebaseFirestore.instance
                              .collection('orders')
                              .doc(widget.data['orderid']);
                          dropdownNameValue = value!;
                          if (dropdownNameValue == 'Delivered') {
                            orderRef.update({
                              'status': dropdownNameValue,
                              'isActive': false
                            });
                          } else {
                            orderRef.update({'status': dropdownNameValue});
                          }
                        },
                      );
                    },
                    items:
                        nameList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ]),
      ),
    ));
  }
}
