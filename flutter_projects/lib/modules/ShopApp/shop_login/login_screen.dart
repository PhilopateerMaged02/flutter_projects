import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/layout/shop_app/shop_layout.dart';
import 'package:news_app/modules/ShopApp/register/register_screen.dart';
import 'package:news_app/modules/ShopApp/shop_login/cubit/cubit.dart';
import 'package:news_app/modules/ShopApp/shop_login/cubit/states.dart';
//import 'package:news_app/modules/register/register_screen.dart';
//import 'package:news_app/modules/shop_login/cubit/cubit.dart';
//import 'package:news_app/modules/shop_login/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopAppLoginStates>(
        listener: (BuildContext context, ShopAppLoginStates state)
        {
          if (state is ShopAppLoginSuccessState) {
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
        builder: (BuildContext context, ShopAppLoginStates state) =>Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN' ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jannah',
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('login now to browse our hot offers' ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jannah',
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
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
                          prefix: Icons.email_outlined),
                      SizedBox(height: 40,),
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
                        prefix: Icons.lock_outlined,
                        suffix: ShopLoginCubit.get(context).suffix,
                        onFieldSubmitted: (value)
                        {
                          if(formKey.currentState!.validate())
                          {
                            ShopLoginCubit.get(context).loginUser(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        onSuffix: ()
                        {
                          ShopLoginCubit.get(context).changePasswordVisibility();
                        },
                        isObscure: ShopLoginCubit.get(context).isPassword,
                      ),
                      SizedBox(height: 40,),
                      ConditionalBuilder(
                        condition: state is! ShopAppLoginLoadingState,
                        builder: (BuildContext context)
                        {
                          return defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).loginUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'LOGIN');
                          },
                        fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          TextButton(
                              onPressed: ()
                              {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text('Create an account',style: TextStyle(color: Colors.blue),))
                        ],
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