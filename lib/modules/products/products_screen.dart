import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.changeFavoritesModel.status){
            showToast(message: state.changeFavoritesModel.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit =ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => productBuilder(context: context ,cubit: cubit
              ,homeModel: cubit.homeModel,categoriesModel: cubit.categoriesModel),
          fallback: (context) => Center(child: buildSpinKit()),
        );
      },
    );
  }

  Widget productBuilder({HomeModel homeModel,CategoriesModel categoriesModel,ShopCubit cubit, BuildContext context}) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: homeModel.data.banners
                .map((e) => Image(
                      image: NetworkImage(
                        e.image.toString(),
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )).toList(),
            options: CarouselOptions(
              aspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 4.5),
              initialPage: 0,
              reverse: false,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              //autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index,res){
                cubit.changeCurrentIndicator(index);
              }
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: homeModel.data.banners.map((e) {
                int index = homeModel.data.banners.indexOf(e);
                return Container(
                  width: index == cubit.currentIndicator ?35 :17,
                  height: 3,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: index == cubit.currentIndicator ?defaultColor: Color.fromRGBO(211, 211, 211, 1)
                  ),
                );
              }).toList()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(
                  'Categories',
                  style:Theme.of(context).textTheme.headline5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.209,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>buildCategoriesItem(context, categoriesModel.data.categoriesData[index]),
                      separatorBuilder: (context,index)=>SizedBox(width: 25,),
                      itemCount: categoriesModel.data.categoriesData.length
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      'New Products',
                      style:Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: defaultColor)
                      ),
                      child: Text('SHOP NOW',style:Theme.of(context).textTheme.bodyText1.copyWith(color:  defaultColor),),
                    )
                  ],
                ),
                GridView.count(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  crossAxisCount:2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      homeModel.data.products.length, (index) => buildGridProduct( homeModel.data.products[index],context)
                  ),
                  childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.38),
                  mainAxisSpacing:3,
                  crossAxisSpacing: 3,
                )

              ],
            ),
          ),


        ],
      ),
    );
  }
  Widget buildCategoriesItem(BuildContext context,Data model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.yellow.withOpacity(0.3),
                  offset: Offset(0, 3),
                  blurRadius: 7,
                  spreadRadius:0.5
              ),
            ],
            border: Border.all(color: Colors.yellow,width: 3),
            shape: BoxShape.circle
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Image(
              height: 65,
                image: NetworkImage(model.image.toString())
            ),
          ),
        ),
      ),
      SizedBox(height: 5,),
      Text(
        model.name.toString(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: Theme.of(context).textTheme.subtitle2.copyWith(height: 1.3),
      )
    ],
  );
  Widget buildGridProduct(Products model, BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.black12.withOpacity(0.05))),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                 height: 180,
                 width: double.infinity,
                  child:Center(
                    child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Image(image: NetworkImage(model.image))),
                  ),
                ),
                Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      child: Icon(ShopCubit.get(context).favorites[model.id]?
                          Icons.favorite : Icons.favorite_border,
                          color: ShopCubit.get(context).favorites[model.id]?
                          defaultColor : Colors.grey,
                          size: 24
                      ),
                      onTap: (){
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                    )
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    style:Theme.of(context).textTheme.bodyText2.copyWith(height: 1.1),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                          'EGP',
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                      SizedBox(width: 5,),
                      Text(
                        '${model.price.round()}',
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5),
                  if ( model.discount != 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Text(
                        'EGP ${model.oldPrice.round()}',
                        style: TextStyle(
                            color: Color.fromRGBO(136, 142, 162, 1),
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                     Container(
                       padding: EdgeInsets.symmetric(vertical: 1,horizontal: 2),
                        margin: EdgeInsets.only(left: 8),
                        color: kLightRedColor,
                        child: Center(
                          child: Text(
                            '${model.discount}% OFF',
                            style: TextStyle(
                                color: kRedColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


