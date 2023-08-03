import 'dart:developer';
import 'package:admin/domain/models/product_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';
import '../../application/add_product_provider/add_product_provider.dart';
import '../../constants/constants.dart';
import '../add_product/add_new_product.dart';
import '../widgets/textfield_widget.dart';

class ScreenEdite extends StatelessWidget {
  const ScreenEdite({
    Key? key,
    required this.details,
  }) : super(key: key);

  final DocumentSnapshot details;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List imageList = [];
    imageList = details['imageList'];
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
                Consumer<AddProductProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      Center(
                        child: imageList.isNotEmpty
                            ? FlutterCarousel(
                                items: List.generate(
                                  imageList.length,
                                  (index) => SizedBox(
                                    width: size.width * 0.7,
                                    child: Image.network(
                                      imageList[index],
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
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Provider.of<AddProductProvider>(context,
                                  listen: false)
                              .pickImage(context);

                          debugPrint(value.imageModels.toString());
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
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Product Name",
                        textString: details['productname'],
                        textController: nameController,
                        enableTextField: true,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "SubName",
                        enableTextField: true,
                        textString: details["subname"],
                        textController: subnameController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Category",
                        enableTextField: true,
                        textString: details["category"],
                        textController: categoryController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Quantity",
                        enableTextField: true,
                        textString: details["quantity"],
                        textController: quantityController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Price",
                        enableTextField: true,
                        textString: details["price"],
                        textController: priceController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Color",
                        enableTextField: true,
                        textString: details["color"],
                        textController: colorController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Description",
                        enableTextField: true,
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
            child: TextButton(
              onPressed: () {
                Provider.of<AddProductProvider>(context, listen: false)
                    .editProduct(
                        Products(
                            productName: nameController.text,
                            subname: subnameController.text,
                            category: categoryController.text,
                            quantity: quantityController.text,
                            price: priceController.text,
                            color: pickedColers,
                            description: descriptionController.text),
                        details)
                    .then(
                      (value) => Navigator.pop(context),
                    );
                log(nameController.text.toString());
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                        horizontal: size.width * 0.32, vertical: 20)),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
