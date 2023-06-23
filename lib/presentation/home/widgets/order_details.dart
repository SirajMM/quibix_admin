// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'order_details_tile.dart';
import 'order_status.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({
    super.key,
  });

  List<String> nameList = <String>[
    'Placed',
    'Shipped',
    'Out of Delivery',
    'Delivered'
  ];

  @override
  Widget build(BuildContext context) {
    String dropdownNameValue = nameList.first;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          const DetailsTile(title: 'user@gmail.com', maintitle: 'Email'),
          const DetailsTile(
              height: 110,
              title: '${'User\n'}${'Kochi\n'}${'Alappatt (H)'}',
              maintitle: 'Adress'),
          const DetailsTile(title: '24-06-2020', maintitle: 'Ordered on'),
          const DetailsTile(title: 'RazorPay', maintitle: 'Payment Method'),
          const DetailsTile(title: 'Tv', maintitle: 'Products'),
          const OrderDetailsActive(),
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
                          dropdownNameValue = value!;
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
