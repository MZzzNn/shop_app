import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favoriter_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../models/login_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';


class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel ;
  Map<int,bool> favorites = {};

  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token:  token).
    then((value) {

      homeModel=HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());

    });
  }

  int currentIndicator = 0;
  void changeCurrentIndicator(index) {
    currentIndicator = index;
    emit(ShopChangeIndicatorState());
  }





  CategoriesModel categoriesModel ;
  void getCategoriesData(){
    DioHelper.getData(url: GET_CATEGORIES, token:  token).
    then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());

    });
  }







  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId){

    favorites[productId]  =! favorites[productId];
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {"product_id":productId},
        token: token
    ).then((value) {
      buildSpinKit();
      changeFavoritesModel= ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel.status){
        favorites[productId]  =! favorites[productId];
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));

    }).
    catchError((error){
      favorites[productId]  =! favorites[productId];
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel ;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token:  token).
    then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }





  LoginModel userModel ;
  void getUserData(){
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(url: PROFILE, token:  token).
    then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
  }){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        data: {
          "name":  name,
          "email":  email,
          "phone":  phone,
          "password":  password,
        },
        token:  token
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
  IconData iconPassVisibility= Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility() {
    iconPassVisibility =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(UpdatePasswordVisibilityState());
  }



}