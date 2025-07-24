import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/widgets/custom_text_feild.dart';
import 'package:fruit_market_dashboard/features/add%20product/presentation/views/widgets/image_feild.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                onSaved: (value) {},
              ),
              SizedBox(height: 10),
              CustomTextFormFeild(
                hintText: 'Product Code',
                keyboardType: TextInputType.number,
                onSaved: (value) {},
              ),
              SizedBox(height: 10),
              CustomTextFormFeild(
                hintText: 'Price',
                keyboardType: TextInputType.number,
                onSaved: (value) {},
              ),
              SizedBox(height: 10),
              CustomTextFormFeild(
                hintText: 'Description',
                maxLines: 5,
                keyboardType: TextInputType.text,
                onSaved: (value) {},
              ),
              SizedBox(height: 10),
              ImageFeild(),
            ],
          ),
        ),
      ),
    );
  }
}
