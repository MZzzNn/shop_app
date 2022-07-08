import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                        defaultFormField(
                            context: context,
                            controller: searchController,
                            type: TextInputType.text,
                            validate: (String val){
                              if(val.isEmpty)
                                return "enter text to search";
                            },
                            label: 'What are you looking for?',
                            prefix: Icons.search,
                            onSubmit: (String text){
                              if(formKey.currentState.validate()){
                                cubit.search(text: text);
                              }
                              },
                            onChange:  (String text){
                              if(formKey.currentState.validate()){
                              cubit.search(text: text);
                              }
                            },
                          suffix: Icons.clear,
                          suffixPressed: (){
                            searchController.text='';
                          }
                        ),

                      SizedBox(height: 10,),

                      if(state is SearchLoadingState) buildSpinKit(),

                      SizedBox(height: 10,),
                      if(state is SearchSuccessState) Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListProduct(
                                cubit.searchModel.data.data[index], context,isSearch: true),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: cubit.searchModel.data.data.length),
                      ),
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
