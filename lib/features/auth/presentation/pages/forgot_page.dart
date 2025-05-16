import 'package:dac/core/constant/app_enum.dart';
import 'package:dac/core/constant/app_values.dart';
import 'package:dac/features/auth/presentation/pages/otp_page.dart';
import 'package:dac/features/auth/presentation/widgets/auth_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_sizes.dart';
import '../../../../core/widgets/app_show_info.dart';
import '../../../../core/widgets/app_input_widgets.dart';
import '../../data/models/otp_send_request_model.dart';
import '../bloc/authentication_bloc.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is OtpLoading) {
            appLoadingDialog(context);
          } else if (state is OtpSuccess) {
            Navigator.pop(context); // Close the loading dialog
            final OtpSendRequestModel otpSendRequestModel = OtpSendRequestModel(
              email: emailController.text,
              type: OtpType.forget_member.name,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BlocProvider(
                      create: (_) => AuthenticationBloc(),
                      child: OtpPage(otpSendRequestModel: otpSendRequestModel),
                    ),
              ),
            );
          } else if (state is OtpFailure) {
            Navigator.pop(context); // Close the loading dialog
            appShowInfo(context, content: state.errorMessage);
          }
        },
        child: Form(
          key: forgotFormKey,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(AppSizes.paddingBody),
              shrinkWrap: true,
              children: <Widget>[
                //for head design
                AuthHead(
                  title: 'Forgot Password',
                  subtitle: 'Type your Email to reset your Password',
                ),
                //end for head design
                SizedBox(height: AppSizes.height(context, 50)),
                //start email input field
                Card(
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingBody),
                    child: AppTextFormField(
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        forgotFormKey.currentState?.validate();
                      },
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Please, Enter Email Address'
                            : AppValues.emailRegex.hasMatch(value)
                            ? null
                            : 'Invalid Email Address';
                      },
                      labelText: 'Email',
                      hintText: 'Enter Email Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  ),
                ),
                //end email input field
                SizedBox(height: AppSizes.height(context, 50)),
                //send otp button
                FilledButton(
                  onPressed: () {
                    if (forgotFormKey.currentState!.validate()) {
                      final OtpSendRequestModel otpSendRequestModel =
                          OtpSendRequestModel(
                            email: emailController.text,
                            type: OtpType.forget_member.name,
                          );
                      // Call the send OTP event
                      context.read<AuthenticationBloc>().add(
                        SendOtpEvent(otpSendRequestModel: otpSendRequestModel),
                      );
                    }
                  },
                  child: Text("Send OTP"),
                ),
                //end send otp button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
