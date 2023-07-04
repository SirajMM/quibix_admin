import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';
import '../../application/add_product_provider/add_product_provider.dart';
import '../../constants/constants.dart';
import '../widgets/textfield_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.details,
  }) : super(key: key);

  final DocumentSnapshot details;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final collection = FirebaseFirestore.instance.collection('products');
    final reference = collection.doc(details.id);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: kMainBgColor,
          appBar: AppBar(
            backgroundColor: kMainBgColor,
            elevation: 0,
            foregroundColor: Colors.black,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: const Text(
              "Product Details",
              style: TextStyle(
                color: kTextBlackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: editNotifier,
                  builder: (context, editOrUpdate, child) => Column(
                    children: [
                      Center(
                        child: details['imageList'].isNotEmpty
                            ? FlutterCarousel(
                                items: List.generate(
                                  details['imageList'].length,
                                  (index) => SizedBox(
                                    width: size.width * 0.7,
                                    child: Image.network(
                                      details['imageList'][index],
                                    ),
                                  ),
                                ),
                                options: CarouselOptions(
                                  indicatorMargin: 5,
                                  viewportFraction: 1,
                                  slideIndicator: const CircularSlideIndicator(
                                    indicatorRadius: 4,
                                    itemSpacing: 15,
                                    currentIndicatorColor: Colors.black,
                                    indicatorBackgroundColor: Colors.grey,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: size.width * 0.7,
                                width: size.width * 0.7,
                                child: const Center(
                                    child: Text('Image not added')),
                              ),
                      ),
                      Visibility(
                        visible: !editOrUpdate,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            editOrUpdate
                                ? null
                                : Provider.of<AddProductProvider>(context,
                                        listen: false)
                                    .pickImage(context);
                          },
                          label: const Text(
                            "Add Image",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Product Name",
                        textString: details['productname'],
                        textController: nameController,
                        enableTextField: !editOrUpdate,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "SubName",
                        enableTextField: !editOrUpdate,
                        textString: details["subname"],
                        textController: subnameController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Category",
                        enableTextField: !editOrUpdate,
                        textString: details["category"],
                        textController: categoryController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Quantity",
                        enableTextField: !editOrUpdate,
                        textString: details["quantity"],
                        textController: quantityController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Price",
                        enableTextField: !editOrUpdate,
                        textString: details["price"],
                        textController: priceController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Color",
                        enableTextField: !editOrUpdate,
                        textString: details["color"],
                        textController: colorController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Description",
                        enableTextField: !editOrUpdate,
                        textString: details['description'],
                        textController: descriptionController,
                        height: 150,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder<bool>(
              valueListenable: editNotifier,
              builder: (context, editOrUpdate, child) => TextButton(
                onPressed: () async {
                  if (editOrUpdate) {
                    editNotifier.value = !editNotifier.value;
                  } else {
                    await reference.update({
                      'productname': nameController.text,
                      'subname': subnameController.text,
                      'category': categoryController.text,
                      'quantity': quantityController.text,
                      'price': priceController.text,
                      'color': colorController.text,
                      'description': descriptionController.text,
                      'imageList': Provider.of<AddProductProvider>(context,
                              listen: false)
                          .imageModels,
                    }).then(
                        (value) => editNotifier.value = !editNotifier.value);
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: size.width * 0.32, vertical: 20)),
                ),
                child: Text(
                  editOrUpdate ? '   Edit   ' : 'Update',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final ValueNotifier<bool> editNotifier = ValueNotifier(true);

final TextEditingController nameController = TextEditingController();

final TextEditingController subnameController = TextEditingController();

final TextEditingController categoryController = TextEditingController();

final TextEditingController quantityController = TextEditingController();

final TextEditingController priceController = TextEditingController();

final TextEditingController colorController = TextEditingController();

final TextEditingController descriptionController = TextEditingController();
