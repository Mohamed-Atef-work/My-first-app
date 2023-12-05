import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/news_app/cubit/cubit.dart';
import 'package:my_first_app/layout/news_app/cubit/states.dart';
import 'package:my_first_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state){},
      builder: (context, state)
      {

        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                  controller: searchEditingController,
                  type: TextInputType.text,
                  onChange: (value)
                  {
                    NewsCubit.get(context).getSearch("value");
                    //getSearchWord(value);
                  },
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return "Search must not be empty";
                    }
                    return null;
                  },
                  label: "Search",
                  prefix: Icons.search,
                ),
                Expanded(child: articleBuilder(list ,isSearch: true)),
              ],
            ),
          ),
        );
      },
    );
  }
}
