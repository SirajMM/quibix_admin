import 'package:admin/domain/functions/db_functions.dart';
import 'package:admin/domain/models/product_models.dart';
import 'package:admin/presentation/add_product/widgets/color_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../application/add_product_provider/add_product_provider.dart';
import '../../constants/constants.dart';
import '../widgets/textfield_widget.dart';

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
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          "Add Product",
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

                  return SizedBox(
                    width: size.width * 0.7,
                    height: size.width * 0.7,
                    child: value.imageModels.isEmpty
                        ? SizedBox(
                            height: size.height * 0.3,
                            child: const Center(
                              child: Text(
                                'Add Image',
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
                            itemBuilder: (context, index) {
                              imageIndex = index;
                              return CachedNetworkImage(
                                width: size.width * 0.7,
                                height: size.width * 0.7,
                                fit: BoxFit.contain,
                                imageUrl: value.imageModels[index],
                                placeholder: (context, url) => Image.asset(
                                    'assets/images/loadinganimation.gif'),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              );
                            }),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Provider.of<AddProductProvider>(context).imageModels.isNotEmpty
                    ? TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Provider.of<AddProductProvider>(context,
                                  listen: false)
                              .deletePickedImage(imageIndex!);
                        },
                        label: const Text(
                          "delet Image",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                      )
                    : const SizedBox(),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Provider.of<AddProductProvider>(context, listen: false)
                        .pickImage(context);
                  },
                  label: const Text(
                    "Pick Image",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
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
            ColorPickerWidget(slectedColors: slectedColors),
            // DetailsTextFieldWidget(
            //   size: size,
            //   fieldName: "Color",
            //   textController: colorController,
            // ),
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
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      Provider.of<AddProductProvider>(context, listen: false)
                          .imageModels
                          .isEmpty) {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "Fields can't be empty",
                      ),
                    );
                    return;
                  }
                  addProduct(
                          Products(
                              productName: nameController.text,
                              subname: subnameController.text,
                              category: categoryController.text,
                              quantity: quantityController.text,
                              price: priceController.text,
                              color: pickedColers = slectedColors
                                  .map((color) => color.value.toString())
                                  .toList(),
                              imageList: Provider.of<AddProductProvider>(
                                      context,
                                      listen: false)
                                  .imageModels,
                              description: descriptionController.text),
                          context)
                      .then((value) {
                    nameController.clear();
                    subnameController.clear();
                    categoryController.clear();
                    quantityController.clear();
                    priceController.clear();
                    colorController.clear();
                    descriptionController.clear();
                    Provider.of<AddProductProvider>(context, listen: false)
                        .imageModels
                        .clear();
                  });
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
                child: const Text(
                  'Submit',
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
int? imageIndex;

List<String> pickedColers = [];
List<Color> slectedColors = [];
