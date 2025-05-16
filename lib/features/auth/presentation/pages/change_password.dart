import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_sizes.dart';
import '../../../../core/widgets/app_show_info.dart';
import '../../../../core/widgets/app_input_widgets.dart';
import '../../data/models/change_password_request_model.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/auth_head.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController passwordCon1 = TextEditingController();
  final TextEditingController passwordCon2 = TextEditingController();
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if(state is ChangePasswordLoading) {
            // Show loading dialog
            appLoadingDialog(context);
          } else if (state is ChangePasswordSuccess) {
            Navigator.pop(context); // Close the loading dialog
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password changed successfully")),
            );
          } else if (state is ChangePasswordFailure) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Form(
          key: changePasswordFormKey,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(AppSizes.paddingBody),
              shrinkWrap: true,
              children: [
                AuthHead(
                  title: "Change Password",
                  subtitle:
                      "You can change your password now. Make sure you remember it now.",
                ),
                SizedBox(height: AppSizes.height(context, 50)),
                //start password input field
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingBody),
                    child: Column(
                      children: [
                        AppTextFormField(
                          labelText: 'Old Password',
                          hintText: 'Enter Old Password',
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter old password'
                                : null;
                          },
                          controller: passwordCon1,
                          obscureText: true,
                        ),

                        SizedBox(height: AppSizes.paddingInside,),
                    
                        AppTextFormField(
                          labelText: 'New Password',
                          hintText: 'Enter New Password',
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter new password'
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
                    if (changePasswordFormKey.currentState!.validate()) {
                      final ChangePasswordRequestModel
                      changePasswordRequestModel = ChangePasswordRequestModel(
                        oldPassword: passwordCon1.text,
                        newPassword: passwordCon2.text,
                      );
                      context.read<AuthenticationBloc>().add(
                        ChangePasswordEvent(
                          changePasswordRequestModel: changePasswordRequestModel,
                        ),
                      );
                    }
                  },
                  child: Text("Change Password"),
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