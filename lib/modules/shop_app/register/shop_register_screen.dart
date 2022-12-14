
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/register/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status!)
            {
              //Show Statue if i enter the valid data or not
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then((value)
              {
                token = state.loginModel.data!.token!;
                navigateAndFinish(
                    context,
                    ShopLayout()
                );
              });
            }
            else
            {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {

          return Scaffold(
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
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse out hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value.isEmpty)
                            {
                              return ('please enter your  name');
                            }
                            return null;

                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value.isEmpty || value != '@gmail.com')
                            {
                              return ('please enter your email address');
                            }
                            return null;

                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          suffixPressed: (){
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value){

                          },
                          validate: (value){
                            if(value.isEmpty)
                            {
                              return ('password is too short');
                            }
                            return null;
                          },
                          isPassword:ShopRegisterCubit.get(context).isPassword ,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value){
                            if(value.isEmpty)
                            {
                              return ('please enter your phone number');
                            }
                            return null;

                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        //Condition
                        state is! ShopRegisterLoadingState?  defaultButton(
                          function:()
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name:nameController.text,
                                phone: phoneController.text,
                              );

                            }
                          },
                          text:'register',
                          isUpperCase: true,
                        ):Center(child: CircularProgressIndicator(),),

                      ],
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
