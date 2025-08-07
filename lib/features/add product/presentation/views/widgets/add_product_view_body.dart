import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market_dashboard/core/helper_functions/build_error_bar.dart';
import 'package:fruit_market_dashboard/core/widgets/custom_buttom.dart';
import 'package:fruit_market_dashboard/core/widgets/custom_checkbox.dart';
import 'package:fruit_market_dashboard/core/widgets/custom_text_feild.dart';
import 'package:fruit_market_dashboard/features/add%20product/domain/entities/add_product_input_entity.dart';
import 'package:fruit_market_dashboard/features/add%20product/presentation/manager/add%20product/add_product_cubit.dart';
import 'package:fruit_market_dashboard/features/add%20product/presentation/views/widgets/image_feild.dart';
import 'package:fruit_market_dashboard/features/add%20product/presentation/views/widgets/is_organic.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String productName, productCode, description;
  late num price, expairationMonths, numberOfCaleries, unitAmount;
  File? image;
  bool isFeatured = false;
  bool isOrganic = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductError) {
          buildErrorBar(context, state.error);
        } else if (state is AddProductSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product Added Successfully')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                CustomTextFormFeild(
                  hintText: 'Product Name',
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    productName = value!;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormFeild(
                  hintText: 'Product Code',
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    productCode = value!.toLowerCase();
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormFeild(
                  hintText: 'Price',
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    price = num.parse(value!);
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormFeild(
                  hintText: 'Description',
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    description = value!;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormFeild(
                  hintText: 'Expairation Months',
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    expairationMonths = num.parse(value!);
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormFeild(
                  hintText: 'Number Of Caleries',
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    numberOfCaleries = num.parse(value!);
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormFeild(
                  hintText: 'Unit Amount',
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    unitAmount = num.parse(value!);
                  },
                ),
                const SizedBox(height: 10),
                IsOrganicCheckBox(
                  onChecked: (value) {
                    isOrganic = value;
                  },
                ),
                const SizedBox(height: 10),
                IsFeaturedCheckBox(
                  onChecked: (value) {
                    isFeatured = value;
                  },
                ),
                const SizedBox(height: 10),
                ImageFeild(
                  onFileChanged: (value) {
                    image = value;
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<AddProductCubit, AddProductState>(
                  builder: (context, state) {
                    if (state is AddProductLoading) {
                      return const CircularProgressIndicator();
                    }
                    return CustomButtom(
                      onpressed: () {
                        if (image != null) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            AddProductInputEntity addProductInputEntity =
                                AddProductInputEntity(
                                  productName: productName,
                                  productCode: productCode,
                                  price: price,
                                  description: description,
                                  fileImage: image!,
                                  isFeatured: isFeatured,
                                  isOrganic: isOrganic,
                                  expiryDate: expairationMonths.toInt(),
                                  numberOfCalories: numberOfCaleries.toInt(),
                                  unitAmount: unitAmount.toInt(),
                                  reviews: [],
                                );
                            context.read<AddProductCubit>().addProduct(
                              addProductInputEntity,
                            );
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select an image'),
                            ),
                          );
                        }
                      },
                      text: 'Save Product',
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
