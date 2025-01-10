import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/shop_layout.dart';
import 'package:news_app/modules/ShopApp/register/cubit/cubit.dart';
import 'package:news_app/modules/ShopApp/register/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget
{
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {

    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopAppRegisterStates>(
        listener: (BuildContext context, ShopAppRegisterStates state)
        {
          if (state is ShopAppRegisterSuccessState) {
            if (state.loginModel.status == true) {
              print("Login Successful: ${state.loginModel.message}");

              if (state.loginModel.data?.token != null) {
                CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value)
                {
                  print("Token saved successfully: ${state.loginModel.data?.token}");
                  token = state.loginModel.data!.token!;
                  navigateToandKill(context, ShopScreen());
                }).catchError((error) {
                  print("Error saving token: $error");
                  showToust(
                    message: "Failed to save token",
                    state: ToastStates.ERROR,
                  );
                });
              } else {
                print("Token is null!");
                showToust(
                  message: "Token is null, login failed!",
                  state: ToastStates.ERROR,
                );
              }

            } else {
              print("Login Failed: ${state.loginModel.message}");
              showToust(
                message: state.loginModel.message ?? "Login failed with unknown error",
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, ShopAppRegisterStates state) =>Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text('Create a new Account',style: TextStyle(
                        fontFamily: 'Jannah',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: nameController,
                          input: TextInputType.name,
                          onValidator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Name must not be empty';
                            }
                          },
                          text: 'User Name',
                          prefix: Icons.person),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: emailController,
                          input: TextInputType.emailAddress,
                          onValidator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Email must not be empty';
                            }
                          },
                          text: 'Email Address',
                          prefix: Icons.email),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: passwordController,
                          input: TextInputType.text,
                          onValidator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Password must not be empty';
                            }
                          },
                          text: 'Password',
                          prefix: Icons.lock,
                          //suffix: Icons.remove_red_eye,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSuffix: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isObscure: ShopRegisterCubit.get(context).isPassword),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: phoneController,
                          input: TextInputType.phone,
                          onValidator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Phone must not be empty';
                            }
                          },
                          text: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(height: 30,),
                      ConditionalBuilder(
                        condition: state is! ShopAppRegisterLoadingState,
                        builder: (BuildContext context)
                        {
                          return defaultButton(
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ShopRegisterCubit.get(context).RegisterUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              text: 'REGISTER');
                        },
                        fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}