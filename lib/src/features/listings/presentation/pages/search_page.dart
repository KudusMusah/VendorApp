import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/theme/theme_colors.dart';
import 'package:didi/src/features/listings/presentation/widgets/custom_search_app_bar.dart';
import 'package:didi/src/features/listings/presentation/widgets/recent_searches.dart';
import 'package:didi/src/features/listings/search_bloc/search_bloc.dart';
import 'package:didi/src/features/orders/presentation/widgets/search_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomSearchAppBar(),
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

            if (state is GetSearchProductSuccess) {
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
                            return SearchProduct(product: product);
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                const Column(
                  children: [
                    RecentSearch(text: "Recent search 1"),
                    RecentSearch(text: "Recent search 2"),
                    RecentSearch(text: "Recent search 3"),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  "Popular Categories",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: AppThemeColors.kWhiteColor,
                    fontSize: 15.7.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🏃 Sports",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: AppThemeColors.kWhiteColor,
                        fontSize: 14.8.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "🇬🇭 Ghanaian products",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: AppThemeColors.kWhiteColor,
                        fontSize: 14.8.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "🍖 Food",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: AppThemeColors.kWhiteColor,
                        fontSize: 14.8.sp,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
