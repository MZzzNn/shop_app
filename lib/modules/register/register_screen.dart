import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState)
          {
            if(state.registerModel.status)
            {
              CacheHelper.saveData(key: 'token', value: state.registerModel.data.token).
              then((value) {
                token =state.registerModel.data.token;
                navigateAndFinish(context, ShopLayout());
              });
            }else{
              showToast(message: state.registerModel.message, state: ToastState.ERROR);
              print(state.registerModel.message);
            }
          }
        },
        builder: (context,state){
          var cubit= RegisterCubit.get(context);
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
                            'RRGITER',
                            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 35),
                          ),
                          Text(
                            'Register now to browser our hot offers',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: 30,),
                          defaultFormField(
                              context: context,
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String val){
                                if(val.isEmpty){
                                  return 'please enter your name';
                                }
                              },
                              label: 'User Name',
                              prefix:Icons.person
                          ),
                          SizedBox(height: 15,),
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
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String val){
                                if(val.isEmpty){
                                  return 'please enter your phone number';
                                }
                              },
                              label: 'Phone',
                              prefix:Icons.phone
                          ),
                          SizedBox(height: 15,),
                          defaultFormField(
                              context: context,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: cubit.iconPassVisibility,
                              isPassword: cubit.isPassword,
                              suffixPressed: ()=>cubit.changePasswordVisibility(),

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
                            condition: state is ! RegisterLoadingState,
                            fallback: (context) => Center(child: buildSpinKit()),
                            builder:(context)=> defaultButtons(
                                radius: 50,
                                function: (){
                                  if(formKey.currentState.validate()){
                                    RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                },
                                text: 'register'
                            ),
                          ),
                          SizedBox(height: 15,),

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
