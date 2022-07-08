import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state  is ! ShopLoadingGetFavoritesState  && state  is ! ShopChangeFavoritesState
              && cubit.favoritesModel != null,
            builder: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  buildTitle(cubit.favoritesModel.data.data,context),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildListProduct(
                          cubit.favoritesModel.data.data[index].product, context),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: cubit.favoritesModel.data.data.length),
                ],
              ),
            ),
          fallback: (context) => Center(child: buildSpinKit()),
        );
      },
    );
  }
  Widget buildTitle(model,BuildContext context)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              'My Favorites',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '(${model.length} item)',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ],
    ),
  );

}
