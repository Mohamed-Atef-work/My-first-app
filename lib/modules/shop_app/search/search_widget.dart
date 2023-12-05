import 'package:flutter/material.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../models/shop_models/search_products_model.dart';
import '../../../styles/colors.dart';

class OneSearchedItem extends StatefulWidget {
  SearchedProduct product;

  OneSearchedItem(this.product);

  @override
  State<OneSearchedItem> createState() => _OneSearchedItemState(product);
}

class _OneSearchedItemState extends State<OneSearchedItem> {
  SearchedProduct product;

  _OneSearchedItemState(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          setState(() {});
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
  }
}
