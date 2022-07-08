
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/categories_model.dart';
import '../../shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder:(context)=> ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildItem(cubit.categoriesModel.data.categoriesData[index],context),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
             // separatorBuilder: (context,index)=>myDivider(),
              itemCount: cubit.categoriesModel.data.categoriesData.length
          ),
        );
      },
    );
  }

Widget buildItem(Data model,BuildContext context)=>Card(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  margin: EdgeInsets.symmetric(vertical: 10),
  child: InkWell(
    onTap: () { },
    borderRadius: BorderRadius.circular(15),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12.withOpacity(0.05),)

      ),
      child: Row(
        children: [
          Container(
            height:70,
            width:70,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: defaultColor)
            ),
            child: Center(
              child: Image(image: NetworkImage(model.image),width: 50, height: 50,),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 3,
            child: Text(
              model.name,
              style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 15),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios,size: 20,),
        ],
      ),
    ),
  ),
);
}


// Widget buildCardItem(Data model,BuildContext context)=>Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//           Image(image: NetworkImage(model.image),height: 80,width: 80,),
//           SizedBox(width: 15,),
//           Text(model.name,style: Theme.of(context).textTheme.headline5,),
//           Spacer(),
//           Icon(Icons.arrow_forward_ios,size: 20,)
//       ],
//     ),
//   );
//Container(
//           color: Color(0xffF2F2F2),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
//             child: StaggeredGridView.countBuilder(
//               crossAxisCount: 2,
//               itemCount: cubit.categoriesModel.data.categoriesData.length,
//               itemBuilder: (BuildContext context, int index) => homeCard(
//                 image: cubit.categoriesModel.data.categoriesData[index].image,
//                 title: cubit.categoriesModel.data.categoriesData[index].name,
//                 icon: cubit.categoriesModel.data.categoriesData[index].image,
//               ),
//               staggeredTileBuilder: (int index) => new StaggeredTile.count(
//                   index == 0 ? 2 : 1, index.isEven ? 1.6 : 1.2),
//               mainAxisSpacing: 15.0,
//               crossAxisSpacing: 15.0,
//             ),
//           ),
//         );
//  Widget homeCard({String image, String title, String icon, BuildContext context}) {
//     return InkWell(
//       onTap: () {},
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 image: DecorationImage(
//                     image: NetworkImage(image), fit: BoxFit.cover),
//                 borderRadius: BorderRadius.circular(20)),
//           ),
//           Container(
//               color: Colors.black.withOpacity(0.5),
//               width: double.infinity,
//               padding: EdgeInsets.all(5),
//               child: Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16),
//               )),
//         ],
//       ),
//     );
//   }
//      List<Color> kMixedColors = [
//           Color(0xff71A5D7),
//           Color(0xff72CCD4),
//           Color(0xffFBAB57),
//           Color(0xffF8B993),
//           Color(0xff962D17),
//           Color(0xffc657fb),
//           Color(0xfffb8457),
//         ];
//Center(
//           child: ScaledList(
//             itemColor: (index) {
//               return kMixedColors[index % kMixedColors.length];
//             },
//             showDots: false,
//             itemCount: cubit.categoriesModel.data.categoriesData.length,
//
//             itemBuilder: (index, selectedIndex) {
//               final category =  cubit.categoriesModel.data.categoriesData[index];
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: selectedIndex == index
//                         ? 160
//                         : 130,
//                     child: Image.network(category.image),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     category.name,
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: selectedIndex == index
//                             ? 25
//                             : 20),
//                   )
//                 ],
//               );
//             },
//           ),
//         );
