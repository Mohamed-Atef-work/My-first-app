import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/models/shop_models/favorites_model.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessChangeFavoritesState) {
        if (!state.model.status) {
          showToast(text: state.model.message, state: ToastStates.Error);
        } else {
          showToast(text: state.model.message, state: ToastStates.SUCCESS);
        }
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: state is! ShopLoadingGetFavoritesState,
        builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildOneFavoriteItem(
                ShopCubit.get(context).favoritesModel!.data.data[index].product,
                context),
            separatorBuilder: (context, index) => Divider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data.data.length),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
    });
  }
}

Widget buildOneFavoriteItem(product, BuildContext context) => Padding(
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
                if (product.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
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
                      if (product.discount != 0)
                        Text(
                          "${product.oldPrice}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1.2,
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .changFavorites(product.productId);
                          print(product.productId);
                        },
                        icon: CircleAvatar(
                          backgroundColor: Fav.favorites[product.productId]
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
