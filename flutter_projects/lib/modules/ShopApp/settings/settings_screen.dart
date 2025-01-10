import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/cubit.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/modules/ShopApp/shop_login/cubit/cubit.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';

class SettingssScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopAppCubit,ShopStates>(
        listener: (BuildContext context, state) {  },
        builder: (context,state)
        {
          userNameController.text = ShopAppCubit.get(context).userModel!.data!.name ?? '';
          emailController.text = ShopAppCubit.get(context).userModel!.data!.email ?? '';
          phoneController.text = ShopAppCubit.get(context).userModel!.data!.phone ?? '';
          return ConditionalBuilder(
            condition: ShopAppCubit.get(context).userModel != null,
            builder: (BuildContext context)
            {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      if(state is ShopLoadingUpdateProfileState)
                        LinearProgressIndicator(color: Colors.blue,),
                      SizedBox(height: 20,),
                      Text('User\'s information',
                        style:TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jannah'
                        ) ,),
                      SizedBox(height: 20,),
                      defaultFormField(
                          controller: userNameController,
                          input: TextInputType.name,
                          onValidator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Name must not be Empty';
                            }
                          },
                          text: 'Name',
                          prefix: Icons.person),
                      SizedBox(height: 20,),
                      defaultFormField(
                          controller: emailController,
                          input: TextInputType.emailAddress,
                          onValidator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Email must not be Empty';
                            }
                          },
                          text: 'Email Address',
                          prefix: Icons.email),
                      SizedBox(height: 20,),
                      defaultFormField(
                          controller: phoneController,
                          input: TextInputType.phone,
                          onValidator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Phone must not be Empty';
                            }
                          },
                          text: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(height: 20,),
                      defaultButton(
                          function: ()
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopAppCubit.get(context).updateUserData(
                                  name: userNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: 'update',),
                      SizedBox(height: 20,),
                      defaultButton(
                        function: ()
                        {
                          signOut(context);
                        },
                        text: 'Logout',),
                    ],
                  ),
                ),
              );
            },
            fallback: (BuildContext context)
            {
              return Center(child: CircularProgressIndicator());
            },
          );
        },
      );
  }
}