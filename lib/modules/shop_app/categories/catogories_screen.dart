import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_layout/cubit/states.dart';
import 'package:my_first_app/models/shop_models/categories_model.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, index) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCat(ShopCubit.get(context)
              .categoriesModel!
              .data
              .dataOfAllCategories[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: ShopCubit.get(context)
              .categoriesModel!
              .data
              .dataOfAllCategories
              .length,
        );
      },
    );
  }
}

Widget buildCat(OneCategoryData catModel) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(catModel.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            catModel.name,
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
