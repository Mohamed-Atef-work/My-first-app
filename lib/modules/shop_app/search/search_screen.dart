import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:my_first_app/modules/shop_app/search/cubit/states.dart';
import 'package:my_first_app/modules/shop_app/search/search_widget.dart';
import 'package:my_first_app/shared/components/components.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../models/shop_models/search_products_model.dart';
import '../../../styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: () {},
                        label: "Search",
                        prefix: Icons.search,
                        onSubmit: () {
                          if (formKey.currentState!.validate()) {
                            ShopSearchCubit.get(context).getSearchProductsData(
                              search: searchController.text,
                            );
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is ShopLoadingSearchProductsState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is ShopSuccessSearchProductsState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => OneSearchedItem(ShopSearchCubit.get(context).searchProductsModel!.bigData.data[index]),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: ShopSearchCubit.get(context)
                              .searchProductsModel!
                              .bigData
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildOneSearchItem(SearchedProduct product, BuildContext context) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(product.image),
                  width: 120,
                  height: 120,
                ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 14.0,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "${product.price}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 14.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changFavorites(product.id);
                          print(product.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: Fav.favorites[product.id]
                              ? defaultColor
                              : Colors.grey,
                          radius: 15.0,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


