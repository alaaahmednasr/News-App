import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.getCubit(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    30,
                  ),
                  child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    NewsCubit.getCubit(context).getSearchData(value!);
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                  context: context ,
                ),
              ),
                  
              Expanded(
                child: conditionBuilderItem(
                  list,
                  isSearch: true,
                ),
              ),
              ],
            ),
          );
        });
  }
}
