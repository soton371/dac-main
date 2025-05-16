import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/core/widgets/app_show_info.dart';
import 'package:dac/core/widgets/app_input_widgets.dart';
import 'package:dac/features/auth/presentation/pages/login_page.dart';
import 'package:dac/features/auth/presentation/widgets/auth_head.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/reset_password_request_model.dart';
import '../bloc/authentication_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordCon1 = TextEditingController();
  final TextEditingController passwordCon2 = TextEditingController();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if(state is ResetPasswordLoading) {
            // Show loading dialog
            appLoadingDialog(context);
          } else if (state is ResetPasswordSuccess) {
            Navigator.pop(context); // Close the loading dialog
            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_) => LoginPage()), (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password reset successfully")),
            );
          } else if (state is ResetPasswordFailure) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Form(
          key: resetPasswordFormKey,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(AppSizes.paddingBody),
              shrinkWrap: true,
              children: [
                AuthHead(
                  title: "Reset Password",
                  subtitle:
                      "You can reset your password now. Make sure you remember it now.",
                ),
                SizedBox(height: AppSizes.height(context, 50)),
                //start password input field
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingBody),
                    child: Column(
                      children: [
                        AppTextFormField(
                          labelText: 'New Password',
                          hintText: 'Enter New Password',
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter new password'
                                : null;
                          },
                          controller: passwordCon1,
                          obscureText: true,
                        ),

                        SizedBox(height: AppSizes.paddingInside,),
                    
                        AppTextFormField(
                          labelText: 'Re-type Password',
                          hintText: 'Enter Re-type Password',
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter re-password'
                                : null;
                          },
                          controller: passwordCon2,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
                //end password input field
                SizedBox(height: AppSizes.height(context, 50)),
                FilledButton(
                  onPressed: () {
                    if (resetPasswordFormKey.currentState!.validate()) {
                      if (passwordCon1.text != passwordCon2.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password does not match")),
                        );
                        return;
                      }
                      final ResetPasswordRequestModel
                      resetPasswordRequestModel = ResetPasswordRequestModel(
                        password: passwordCon1.text,
                      );
                      context.read<AuthenticationBloc>().add(
                        ResetPasswordEvent(
                          resetPasswordRequestModel: resetPasswordRequestModel,
                        ),
                      );
                    }
                  },
                  child: Text("Reset Password"),
                ),
                SizedBox(height: AppSizes.height(context, 30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
