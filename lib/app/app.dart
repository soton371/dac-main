import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constant/app_colors.dart';
import '../core/constant/app_urls.dart';
import '../features/applicant/presentation/bloc/applicant_bloc.dart';
import '../features/auth/presentation/bloc/authentication_bloc.dart';
import '../features/auth/presentation/cubit/otp_timer_cubit.dart';
import '../features/company_profile/presentation/bloc/company_bloc.dart';
import '../features/document/presentation/bloc/document_bloc.dart';
import '../features/representative/presentation/bloc/representative_bloc.dart';
import '../features/splash/presentation/bloc/bloc/version_bloc.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VersionBloc(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => OtpTimerCubit(),
        ),
        BlocProvider(
          create: (context) => CompanyBloc(),
        ),
        BlocProvider(
          create: (context) => DocumentBloc(),
        ),
        BlocProvider(
          create: (context) => RepresentativeBloc(),
        ),
        BlocProvider(
          create: (context) => ApplicantBloc(),
        ),
      ],
      child: MaterialApp(
        title: AppUrls.appName,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
          cardTheme: const CardTheme(
            shadowColor: Colors.transparent,
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radius),
              )),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
        ),
        // home: const SplashPage(),
        home: const HomePage(),
      ),
    );
  }
}

