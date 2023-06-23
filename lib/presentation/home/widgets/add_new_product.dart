import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../application/add_product_provider/add_product_provider.dart';
import '../../../constants/constants.dart';
import '../../widgets/textfield_widget.dart';

class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kMainBgColor,
      appBar: AppBar(
        backgroundColor: kMainBgColor,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_left)),
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
            Center(
              child: Consumer<AddProductProvider>(
                builder: (context, value, child) {
                  final size = MediaQuery.of(context).size;

                  return GestureDetector(
                    onTap: () {
                      // value.pickImage();
                      Provider.of<AddProductProvider>(context, listen: false)
                          .pickImage();
                    },
                    child: SizedBox(
                      width: size.width * 0.7,
                      height: size.width * 0.7,
                      child: value.imageModels.isEmpty
                          ? Container(
                              height: size.height * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Text(
                                  'Pick Image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.imageModels.length,
                              itemBuilder: (context, index) => Image.file(
                                File(value.imageModels[index]),
                                fit: BoxFit.contain,
                                width: size.width * 0.7,
                                height: size.width * 0.7,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            DetailsTextFieldWidget(
              size: size,
              fieldName: "Product Name",
              textController: nameController,
            ),
            DetailsTextFieldWidget(
              size: size,
              fieldName: "Sub Name",
              textController: subnameController,
            ),
            DetailsTextFieldWidget(
              size: size,
              fieldName: "Category",
              textController: categoryController,
            ),
            DetailsTextFieldWidget(
              size: size,
              fieldName: "Quantity",
              textController: quantityController,
              numPad: true,
            ),
            DetailsTextFieldWidget(
              size: size,
              fieldName: "Price",
              textController: priceController,
              numPad: true,
            ),
            DetailsTextFieldWidget(
              size: size,
              fieldName: "Color",
              textController: colorController,
            ),
            DetailsTextFieldWidget(
              size: size,
              fieldName: "Description",
              textController: descriptionController,
              height: 160,
              maxLines: 4,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextButton(
                onPressed: () {},
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
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final TextEditingController nameController = TextEditingController();

final TextEditingController subnameController = TextEditingController();

final TextEditingController categoryController = TextEditingController();

final TextEditingController quantityController = TextEditingController();

final TextEditingController priceController = TextEditingController();

final TextEditingController colorController = TextEditingController();

final TextEditingController descriptionController = TextEditingController();

List<String> categoriesList = ["Men", "Women", "Children", "Others"];
