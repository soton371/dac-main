import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:dac/features/auth/presentation/pages/login_page.dart';
import 'package:dac/features/auth/presentation/pages/reset_password_page.dart';
import 'package:dac/features/auth/presentation/widgets/auth_head.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_enum.dart';
import '../../../../core/widgets/app_show_info.dart';
import '../../data/models/otp_send_request_model.dart';
import '../../data/models/otp_verify_request_model.dart';
import '../../data/models/register_request_model.dart';
import '../cubit/otp_timer_cubit.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.otpSendRequestModel, this.registerRequestModel});
  final OtpSendRequestModel otpSendRequestModel;
  final RegisterRequestModel? registerRequestModel;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController pinCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OtpTimerCubit>().startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is OtpVerifyLoading) {
            appLoadingDialog(context);
          } else if (state is OtpVerifySuccess) {
            Navigator.pop(context);
            // Navigate to the next page
            if (widget.otpSendRequestModel.type ==
                OtpType.forget_member.name) {
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (_) => ResetPasswordPage()),
                (route) => false,
              );
            } else {
              Navigator.pop(context);
              //register event call
              context.read<AuthenticationBloc>().add(RegisterEvent(registerRequestModel: widget.registerRequestModel!));
            }
          } else if (state is OtpVerifyFailure) {
            Navigator.pop(context);
            appShowInfo(context, content: state.errorMessage);
          } else if (state is RegisterLoading) {
            // Show loading indicator
            appLoadingDialog(context);
          } else if (state is RegisterSuccess) {
            // Handle successful registration
            Navigator.pop(context); // Close the loading dialog
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => LoginPage()),
              (route) => false,
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Registration successful!')));
          } else if (state is RegisterFailure) {
            // Handle registration failure
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(AppSizes.paddingBody),
            children: [
              AuthHead(
                title: "OTP",
                subtitle:
                    "Enter the code sent to ${widget.otpSendRequestModel.email}",
              ),
              SizedBox(height: AppSizes.height(context, 50)),
              Pinput(
                length: 6,
                controller: pinCon,
                onCompleted: (pin) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ResetPasswordPage(),
                  //   ),
                  // );
                  final otpVerifyRequestModel = OtpVerifyRequestModel(
                    email: widget.otpSendRequestModel.email,
                    otp: pin,
                    type: widget.otpSendRequestModel.type,
                  );
                  context.read<AuthenticationBloc>().add(
                    VerifyOtpEvent(
                      otpVerifyRequestModel: otpVerifyRequestModel,
                    ),
                  );
                },
              ),
              SizedBox(height: AppSizes.height(context, 50)),
              Text("Didn't received email?", textAlign: TextAlign.center),
              BlocBuilder<OtpTimerCubit, OtpTimerState>(
                builder: (context, state) {
                  return state.remainingSeconds == 0
                      ? TextButton(
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(
                            SendOtpEvent(
                              otpSendRequestModel: widget.otpSendRequestModel,
                            ),
                          );
                          context.read<OtpTimerCubit>().resetTimer();
                        },
                        child: Text('Resend OTP'),
                      )
                      : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'You can resend code in ',
                          style: TextStyle(color: AppColors.seed),
                          children: [
                            TextSpan(
                              text: '${state.remainingSeconds}',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: ' seconds',
                              style: TextStyle(color: AppColors.seed),
                            ),
                          ],
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
