import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/components/constants.dart';
import '../../layout/cubit/cubit.dart';
import '../styles/colors.dart';

Widget defaultButtons({
  double width = double.infinity,
  @required Function function,
  bool isUppercase = true,
  double radius = 0.0,
  @required String text,
}) => Container(
        width: width,
        height: 50.0,
        decoration: BoxDecoration(
          color: isDarkC ?Color(0xff00ADB5) :Colors.indigo,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: MaterialButton(
          height: 50,
          shape:RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(radius),
          ),
          onPressed: function,
          child: Text(
            isUppercase ? text.toUpperCase() : text,
            style: TextStyle(color: Colors.white,fontSize: 18),
          ),
        ));

Widget defaultTextButton({
  @required Function function,
  @required String text
})=>  TextButton(
    onPressed:function,
    child: Text(text.toUpperCase(),style: TextStyle(fontSize: 16,color: defaultColor),));


Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  Function onTap,
  IconData suffix,
  bool isClickable = true,
  bool isPassword = false,
  Function suffixPressed,
  @required BuildContext context
}) => TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit, // when i press on the correct button
      onChanged: onChange, //when iam writing
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey[500],fontWeight: FontWeight.w400),
        prefixIcon: Icon(prefix ,color: isDarkC? Colors.white:Colors.grey[500] ,),
        suffixIcon: suffix != null && !controller.text.isEmpty
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix,color: defaultColor,))
            : null,
        border: OutlineInputBorder(borderSide: BorderSide(color: defaultColor)),
        enabledBorder:   OutlineInputBorder(borderSide: BorderSide(color: defaultColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: defaultColor)),
        filled: true,
        fillColor:isDarkC? Color(0xff393E46) : Colors.white,
      ),cursorColor: defaultColor,
      style: Theme.of(context).textTheme.bodyText1,
    );



Widget myDivider({bool verPad=false})=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Container(
    margin: verPad ?EdgeInsets.symmetric(vertical: 10):EdgeInsets.all(0),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildRowItem({BuildContext context , IconData icon ,String title,bool navigate =true ,Function navigateTo,Widget widget})=>Row(
  children: [
    Icon(icon),
    SizedBox(width: 15,),
    Text(title,style: Theme.of(context).textTheme.bodyText1,),
    Spacer(),
    navigate ?IconButton(icon: Icon(Icons.arrow_forward_ios,size: 20,), onPressed:navigateTo):Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: widget,
    ),
  ],
);

void showToast({
  @required String message,
  @required ToastState state
})=>Fluttertoast.showToast(
    msg:message ,
    toastLength: Toast.LENGTH_LONG ,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastState{ SUCCESS ,ERROR , WARNING}

Color chooseToastColor(ToastState state){
  Color toastColor;
  switch(state){
    case ToastState.SUCCESS:
      toastColor=Colors.green;
      break;
    case ToastState.ERROR:
      toastColor=Colors.red;
      break;
    case ToastState.WARNING:
      toastColor=Colors.amber;
      break;
  }
  return toastColor;
}

void navigateTo(context,widget)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));

void navigateAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget),(route)=>false);


Widget buildListProduct(model, BuildContext context, {bool isSearch=false}) =>
    Card(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                         'EGP ${ model.oldPrice.toString()}',
                          style: TextStyle(
                              color: Color.fromRGBO(136, 142, 162, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text('EGP',
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(
                            width: 5,
                          ),
                          Text(model.price.toString(),
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 38,
                ),
                Expanded(
                  child: Image(
                      height: 60,
                      width: 70,
                      image: NetworkImage(model.image.toString())),
                )
              ],
            ),
            if(!isSearch) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart,color: defaultColor,),
                  label: Text(
                    'Move to cart',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(model.id);
                  },
                  icon: Icon(Icons.restore_from_trash,color: defaultColor,),
                  label: Text('Remove',
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ],
            )
          ],
        ),
      ),
    );

Widget buildSpinKit()=>SpinKitDoubleBounce(
  color: defaultColor,
  size: 50.0,
);