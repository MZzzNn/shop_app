
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context,state){
      
        if( state is ShopSuccessUpdateUserState){
          showToast(message: state.loginModel.message, state: ToastState.SUCCESS);
        }
      },
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        nameController.text =cubit.userModel.data.name;
        emailController.text =cubit.userModel.data.email;
        phoneController.text =cubit.userModel.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
            builder: (context)=>Scaffold(
                appBar: AppBar(
                  title: Text('Edit Profile', style: Theme.of(context).textTheme.headline5,),
                  centerTitle: true,
                ),
                body: GestureDetector(
                    onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                    child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                               buildImageCard(context, cubit),
                                Card(
                                  margin: EdgeInsets.symmetric(vertical: 30),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.black12.withOpacity(0.1),)
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          defaultFormField(
                                              context: context,
                                              controller: nameController,
                                              type: TextInputType.name,
                                              validate: (String val) {
                                                if (val.isEmpty) {
                                                  return 'name must not be empty';
                                                }
                                              },
                                              label: 'Your Name',
                                              prefix: Icons.person
                                          ),
                                          SizedBox(height: 15,),
                                          defaultFormField(
                                              context: context,
                                              controller: emailController,
                                              type: TextInputType.emailAddress,
                                              validate: (String val) {
                                                if (val.isEmpty) {
                                                  return 'E-mail must not be empty';
                                                }
                                              },
                                              label: 'E-mail',
                                              prefix: Icons.email_outlined
                                          ),
                                          SizedBox(height: 15,),
                                          defaultFormField(
                                              context: context,
                                              controller: phoneController,
                                              type: TextInputType.phone,
                                              validate: (String val) {
                                                if (val.isEmpty) {
                                                  return 'Phone must not be empty';
                                                }
                                              },
                                              label: 'Phone',
                                              prefix: Icons.phone
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ConditionalBuilder(
                                  condition: state is ! ShopLoadingUpdateUserState,
                                  fallback: (context) => Center(child: buildSpinKit()),
                                  builder:(context)=>  defaultButtons(
                                      function: (){
                                        if(formKey.currentState.validate()){
                                          cubit.updateUserData(
                                              name: nameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              password: passwordController.text
                                          );
                                        }
                                      },
                                      text: 'Update Profile',
                                      radius: 20
                                  ),
                                ),

                              ]
                          ),
                        )
                    )
                )
            ),
          fallback: (context) => Center(child: buildSpinKit()),
        );
      },
    );
  }
  Widget buildImageCard(BuildContext context,var cubit){
    var media = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100))
      ),
      child: Container(
        width: media.width * 0.55,
        height: media.width * 0.53,
        child: Center(
          child: Container(
            width: media.width * 0.40,
            height: media.height * 0.19,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                //  controller.showDialogPickPersonImage();
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.network(
                        "https://student.valuxapps.com/storage/assets/defaults/user.jpg",
                        fit: BoxFit.cover,
                        width: media.width * 0.40,
                        height: media.height * 0.19),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: defaultColor,
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
