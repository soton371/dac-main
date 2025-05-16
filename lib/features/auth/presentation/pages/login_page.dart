import 'package:dac/core/widgets/app_show_info.dart';
import 'package:dac/features/auth/presentation/pages/forgot_page.dart';
import 'package:dac/features/auth/presentation/pages/registration_page.dart';
import 'package:dac/features/auth/presentation/widgets/auth_head.dart';
import 'package:dac/features/home/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/app_values.dart';
import '../../../../core/widgets/app_input_widgets.dart';
import '../../data/models/login_request_model.dart';
import '../bloc/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _logInFormKey = GlobalKey<FormState>();
  bool isObscure = true;
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if(state is LoginLoading){
              appLoadingDialog(context);
            }else if(state is LoginSuccess){
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (_) => const HomePage(),
                ),
              );
            }else if(state is LoginFailure){
              Navigator.pop(context);
              appShowInfo(context,
                title: 'Login Failed',
                content: state.errorMessage,
              );
            }
          },
          child: Form(
            key: _logInFormKey,
            child: Center(
              child: ListView(
                padding: EdgeInsets.all(AppSizes.paddingBody),
                shrinkWrap: true,

                children: <Widget>[
                  //for head design
                  AuthHead(
                    title: 'Sign In',
                    subtitle:
                        'Enter your registered Username or Email and valid Password to sign in',
                  ),
                  //end for head design
                  SizedBox(height: AppSizes.height(context, 50)),
                  //for email text field & password text field
                  Card(
                    shadowColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.paddingBody),
                      child: Column(
                        children: [
                          //start email input field
                          AppTextFormField(
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter email address'
                                  : AppValues.emailRegex.hasMatch(value)
                                  ? null
                                  : 'Invalid email address';
                            },
                            controller: emailController,
                          ),
                          //end email input field
                          SizedBox(height: AppSizes.paddingBody),
                          //start password input field
                          AppTextFormField(
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter password'
                                  : null;
                            },
                            controller: passwordController,
                            obscureText: isObscure,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              icon: Icon(
                                isObscure
                                    ? HugeIcons.strokeRoundedView
                                    : HugeIcons.strokeRoundedViewOff,
                              ),
                            ),
                          ),
                          //end password input field

                          //start route forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed:
                                  () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => const ForgotPage(),
                                    ),
                                  ),
                              style: Theme.of(context).textButtonTheme.style,
                              child: Text(
                                'Forgot Password?',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: AppColors.seed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          //end route forgot password
                        ],
                      ),
                    ),
                  ),
                  //end for email text field & password text field
                  SizedBox(height: AppSizes.height(context, 50)),
                  // start login button
                  FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radius),
                      ),
                    ),
                    onPressed: () {
                      if (_logInFormKey.currentState!.validate()) {
                        final LoginRequestModel loginRequestModel =
                            LoginRequestModel(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                        context.read<AuthenticationBloc>().add(
                          LoginEvent(loginRequestModel: loginRequestModel),
                        );
                      }
                      // Navigator.push(
                      //   context,
                      //   CupertinoPageRoute(builder: (_) => const HomePage()),
                      // );
                    },
                    child: Text("Sign In"),
                  ),
                  // end start login button
                  SizedBox(height: AppSizes.height(context, 30)),
                  //start route registration page
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const RegistrationPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Don\'t have an account? Registration',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.seed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //end route registration page
                  SizedBox(height: AppSizes.height(context, 30)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
