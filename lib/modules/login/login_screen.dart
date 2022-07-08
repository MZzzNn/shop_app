import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';
import 'cubit/states.dart';



class LoginScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context,state){
            if(state is LoginSuccessState)
            {
              if(state.loginModel.status)
              {
                CacheHelper.saveData(key: 'token', value: state.loginModel.data.token).
                then((value) {
                    token =state.loginModel.data.token;
                    navigateAndFinish(context, ShopLayout());
                });
              }else{
                showToast(message: state.loginModel.message, state: ToastState.ERROR);
                print(state.loginModel.message);
              }
            }
          },
          builder: (context,state){
            var cubit= LoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LOGIN',
                              style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 35),
                            ),
                            Text(
                              'Login now to browser our hot offers',
                              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.grey),
                            ),
                            SizedBox(height: 30,),
                            defaultFormField(
                               context: context,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String val){
                                  if(val.isEmpty){
                                    return 'please enter your email address';
                                  }
                                },
                                label: 'E-mail',
                                prefix:Icons.email_outlined
                            ),
                            SizedBox(height: 15,),
                            defaultFormField(
                                context: context,
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                suffix: cubit.iconPassVisibility,
                                isPassword: cubit.isPassword,
                                suffixPressed: ()=>cubit.changePasswordVisibility(),
                                onSubmit: (val){
                                  if(formKey.currentState.validate()){
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                },
                                validate: (String val){
                                  if(val.isEmpty){
                                    return 'password is to short';
                                  }
                                },
                                label: 'Password',
                                prefix:Icons.lock_outline
                            ),
                            SizedBox(height: 30,),
                            ConditionalBuilder(
                              condition: state is ! LoginLoadingState,
                              fallback: (context) => Center(child: buildSpinKit()),
                              builder:(context)=> defaultButtons(
                                  radius: 50,
                                  function: (){
                                    if(formKey.currentState.validate()){
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text
                                      );
                                    }
                                  },
                                  text: 'login'
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                defaultTextButton(
                                    function: ()=>navigateTo(context, RegisterScreen()),
                                    text: 'register'
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
