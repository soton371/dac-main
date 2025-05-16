import 'package:dac/core/constant/app_enum.dart';
import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/core/widgets/app_input_widgets.dart';
import 'package:dac/features/auth/data/models/otp_send_request_model.dart';
import 'package:dac/features/auth/presentation/pages/otp_page.dart';
import 'package:dac/features/auth/presentation/widgets/auth_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_show_info.dart';
import '../../data/models/register_request_model.dart';
import '../bloc/authentication_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
            final RegisterRequestModel registerRequestModel =
                          RegisterRequestModel(
                            userName: _usernameController.text,
                            companyName: _companyNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneController.text,
                          );
            final OtpSendRequestModel otpSendRequestModel = OtpSendRequestModel(
              email: _emailController.text,
              type: OtpType.email_verification.name,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BlocProvider(
                      create: (_) => AuthenticationBloc(),
                      child: OtpPage(otpSendRequestModel: otpSendRequestModel, registerRequestModel: registerRequestModel),
                    ),
              ),
            );
          } else if (state is OtpFailure) {
            Navigator.pop(context); // Close the loading dialog
            appShowInfo(context, content: state.errorMessage);
          }
        },
        child: Form(
          key: _registrationFormKey,
          child: Center(
            child: ListView(
              padding: const EdgeInsets.all(AppSizes.paddingBody),
              shrinkWrap: true,
              children: <Widget>[
                AuthHead(
                  title: 'Registration',
                  subtitle: 'Please fill in the details below to register.',
                ),
                SizedBox(height: AppSizes.height(context, 50)),
                // Add your text fields for registration here
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.paddingBody),
                    child: Column(
                      children: [
                        AppTextFormField(
                          labelText: "Company Name",
                          hintText: "Enter Company Name",
                          controller: _companyNameController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Please enter company name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSizes.paddingInside),
                        AppTextFormField(
                          labelText: "Username",
                          hintText: "Enter Username",
                          controller: _usernameController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Please enter username";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSizes.paddingInside),
                        AppTextFormField(
                          labelText: "Email",
                          hintText: "Enter Email",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Please enter email";
                            } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            ).hasMatch(p0)) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSizes.paddingInside),
                        AppTextFormField(
                          labelText: "Phone Number",
                          hintText: "Enter Phone Number",
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Please enter phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSizes.paddingInside),
                        AppTextFormField(
                          labelText: "Password",
                          hintText: "Enter Password",
                          controller: _passwordController,
                          obscureText: true,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // end your text fields for registration here
                SizedBox(height: AppSizes.height(context, 50)),
                FilledButton(
                  onPressed: () {
                    // Handle registration logic here
                    if (_registrationFormKey.currentState!.validate()) {
                      final OtpSendRequestModel otpSendRequestModel =
                          OtpSendRequestModel(
                            email: _emailController.text,
                            type: OtpType.email_verification.name,
                          );
                      context.read<AuthenticationBloc>().add(
                        SendOtpEvent(otpSendRequestModel: otpSendRequestModel),
                      );
                    }
                  },
                  child: Text("Register"),
                ),
                SizedBox(height: AppSizes.height(context, 30)),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Already have an account?",
                    textAlign: TextAlign.center,
                  ),
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
