import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/constants.dart';
import 'package:didi/src/features/listings/search_bloc/search_bloc.dart';
import 'package:didi/src/features/listings/seller_shops_blocs/seller_shops_bloc.dart';
import 'package:didi/src/features/orders/presentation/widgets/seller_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:routemaster/routemaster.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  @override
  void initState() {
    super.initState();
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    context
        .read<SearchProductBloc>()
        .add(GetSellerProductEvent(token: user.token));
    context.read<SellerShopsBloc>().add(SellerGetAllShops(token: user.token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
        child: BlocBuilder<SearchProductBloc, SearchProductState>(
          builder: (context, state) {
            if (state is SearchProductFailure) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is SearchProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is GetSellerProductsSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            children: state.products.map(
                          (product) {
                            return SellerProductItem(product: product);
                          },
                        ).toList()),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(height: 3.h),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Routemaster.of(context).push('create_screen'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
