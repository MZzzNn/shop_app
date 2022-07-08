import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  bool isDark = CacheHelper.getData(key: 'isDark');
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel != null &&cubit.userModel.data !=null ,
          fallback: (context) => Center(child: buildSpinKit()),
          builder: (context)=>Container(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Welcome ${cubit.userModel.data.name}",style: Theme.of(context).textTheme.headline5,),
                          Text("${cubit.userModel.data.email}",style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 5, right: 16,left: 16,top: 25),
                      child: Text('MY ACCOUNT',style: Theme.of(context).textTheme.headline5,),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black12.withOpacity(0.05),)
                          ),
                          child: Column(
                            children: [

                              buildRowItem(
                                  context: context,
                                  icon: Icons.person,
                                  title: 'Edit Profile',
                                  navigateTo: (){
                                    navigateTo(context, EditProfileScreen());
                                  }
                              ),
                              myDivider(verPad: true),
                              buildRowItem(
                                  context: context,
                                  icon: Icons.description,
                                  title: 'Orders',
                                  navigateTo: (){}
                              ),
                              myDivider(verPad: true),
                              buildRowItem(
                                  context: context,
                                  icon: FontAwesomeIcons.gratipay,
                                  title: 'My Favorites',
                                  navigateTo: (){}
                              ),
                              myDivider(verPad: true),
                              buildRowItem(
                                  context: context,
                                  icon: FontAwesomeIcons.wallet,
                                  title: 'My Wallet',
                                  navigate: false,
                                  widget: Text('${cubit.userModel.data.credit} EG',style:Theme.of(context).textTheme.bodyText1 ,)
                              ),
                            ],
                          )
                      ),
                    ),


                    Padding(
                      padding: EdgeInsets.only(bottom: 5, right: 16,left: 16,top: 25),
                      child: Text('SETTINGS',style: Theme.of(context).textTheme.headline5,),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black12.withOpacity(0.05),)
                          ),
                          child: Column(
                            children: [
                              buildRowItem(
                                  context: context,
                                  icon: FontAwesomeIcons.globe,
                                  title: 'Country',
                                  navigateTo: (){}
                              ),
                              myDivider(verPad: true),
                              buildRowItem(
                                  context: context,
                                  icon: Icons.flag_outlined,
                                  title: 'language',
                                  navigateTo: (){}
                              ),
                              myDivider(verPad: true),
                              buildRowItem(
                                  context: context,
                                  icon: Icons.wb_incandescent_rounded,
                                  title: 'Theme',
                                  navigate: false,
                                  widget: FlutterSwitch(
                                    value: AppCubit.get(context).isDark,
                                    showOnOff: false,
                                    height: 27,
                                    width:52.5 ,
                                    toggleSize:22 ,
                                    padding: 3,
                                    activeToggleColor:defaultColor,
                                    inactiveToggleColor: Color(0xFF2F363D),
                                    activeSwitchBorder: Border.all(
                                      color: defaultColor,
                                      width: 2.0,
                                    ),
                                    inactiveSwitchBorder: Border.all(
                                      color: Color(0xFFD1D5DA),
                                      width: 2.0,
                                    ),
                                    activeColor: Color(0xff222831),
                                    inactiveColor: Colors.white,
                                    activeIcon: Icon(
                                      Icons.nightlight_round,
                                      color: Color(0xFFF8E3A1),
                                    ),
                                    inactiveIcon: Icon(
                                      Icons.wb_sunny,
                                      color: Color(0xFFFFDF5D),
                                    ),
                                    onToggle: (val) {
                                        AppCubit.get(context).changeAppMode();
                                    },
                                  )
                              ),

                              myDivider(verPad: true),
                              buildRowItem(
                                  context: context,
                                  icon: Icons.notifications_none,
                                  title: 'Notifications',
                                  navigateTo: (){}
                              ),

                            ],
                          )
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 5, right: 16,left: 16,top: 25),
                      child: Text('REACH OUT TO US',style: Theme.of(context).textTheme.headline5,),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black12.withOpacity(0.05),)
                          ),
                          child: Column(
                            children: [
                              buildRowItem(
                                  context: context,
                                  icon: FontAwesomeIcons.infoCircle,
                                  title: 'Help',
                                  navigateTo: (){}
                              ),
                              myDivider(verPad: true),
                              buildRowItem(
                                  context: context,
                                  icon: Icons.phone,
                                  title: 'Contact Us',
                                  navigateTo: (){}
                              ),
                            ],
                          )
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 16,left: 16,top: 10),
                      child: TextButton.icon(
                        label:Text('Sign Out',style: TextStyle(color: defaultColor),) ,
                        icon: Icon( Icons.logout,size: 30,color: defaultColor,),
                        onPressed: (){signOut(context);},
                      ),
                    ),

                    SizedBox(height: media.height * 0.03,),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}


