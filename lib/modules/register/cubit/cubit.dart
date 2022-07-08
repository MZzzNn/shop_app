

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);
  LoginModel loginModel;

  void userRegister({
  @required String name,
  @required String email,
  @required String phone,
  @required String password,
}){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          "name" : name,
          "email" : email,
          "phone" : phone,
          "password" : password
        },
    ).then((value) {
      loginModel =LoginModel.fromJson(value.data);
      print(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData iconPassVisibility= Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility() {
    iconPassVisibility =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(RegisterPasswordVisibilityState());
  }

}