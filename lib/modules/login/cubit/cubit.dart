

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);
  LoginModel loginModel;

  void userLogin({
  @required String email,
  @required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          "email" : email,
          "password" : password
        },
    ).then((value) {
      loginModel =LoginModel.fromJson(value.data);
      print(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData iconPassVisibility= Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility() {
    iconPassVisibility =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(LoginPasswordVisibilityState());
  }

}