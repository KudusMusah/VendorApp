import 'dart:io';

import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/utils/pick_image.dart';
import 'package:didi/src/core/utils/snackbar.dart';
import 'package:didi/src/features/listings/models/shops.dart';
import 'package:didi/src/features/listings/search_bloc/search_bloc.dart';
import 'package:didi/src/features/listings/seller_crud_bloc/seller_crud_bloc.dart';
import 'package:didi/src/features/listings/seller_shops_blocs/seller_shops_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();
  Shop? selectedShop;
  File? bannerFile;

  void selectBannerImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void _addProduct() {
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    final userShops =
        (context.read<SellerShopsBloc>().state as SellerShopsSuccess).shops;
    if (bannerFile != null &&
        titleController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        stockController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      context.read<SellerCrudBloc>().add(
            SellerAddProducts(
              token: user.token,
              title: titleController.text.toString(),
              description: descriptionController.text.toString(),
              image: bannerFile!,
              price: double.parse(priceController.text.trim()),
              shopId: selectedShop == null ? userShops[0].id : selectedShop!.id,
              stockQuantity: int.parse(priceController.text.trim()),
            ),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userShops =
        (context.watch<SellerShopsBloc>().state as SellerShopsSuccess).shops;

    if (userShops.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Product',
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "You have to belong to at least one community in order to create a post",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
        actions: [
          TextButton(
            onPressed: () => _addProduct(),
            child: const Text('Add'),
          ),
        ],
      ),
      body: BlocConsumer<SellerCrudBloc, SellerCrudState>(
        listener: (context, state) {
          if (state is SellerCrudFailure) {
            showSnackBar(context, state.message);
          }
          if (state is SellerAddProductsState) {
            final user =
                (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
            context
                .read<SearchProductBloc>()
                .add(GetSellerProductEvent(token: user.token));
            Routemaster.of(context).pop();
          }
        },
        builder: (context, state) {
          return BlocBuilder<SellerCrudBloc, SellerCrudState>(
            builder: (context, state) {
              if (state is SellerCrudLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'Enter Product Title',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                      maxLength: 40,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: 'Product Price',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: TextField(
                            controller: stockController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: 'Stock Quantity',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Select Image"),
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: selectBannerImage,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        color: Colors.red,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: bannerFile != null
                              ? Image.file(bannerFile!)
                              : const Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'Enter Description here',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Select Shop',
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: DropdownButton(
                        value: selectedShop ?? userShops[0],
                        items: userShops
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedShop = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
