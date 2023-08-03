import 'package:admin/application/search/serch_provide.dart';
import 'package:admin/presentation/Search/widget/product_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import 'widget/custom_search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 12, right: 12),
        child: Column(
          children: [
            khieght10,
            CustomSearchWidget(
              onChanged: Provider.of<SearchProvider>(context, listen: true)
                  .filterUsers,
            ),
            khieght10,
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Consumer<SearchProvider>(
                              builder: (context, value, child) {
                              return GridView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            (itemWidth / itemHeight),
                                        crossAxisSpacing: 16.0,
                                        mainAxisSpacing: 16.0),
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index].data();
                                  if (value.productName.isEmpty) {
                                    return ProductTile(data: data);
                                  }
                                  if (data['productname']
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          value.productName.toLowerCase())) {
                                    return ProductTile(data: data);
                                  }
                                  return Container();
                                },
                              );
                            });
                    }))
          ],
        ),
      ),
    ));
  }
}
