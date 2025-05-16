import 'package:dac/features/applicant/presentation/bloc/applicant_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ApplicantPage extends StatefulWidget {
  const ApplicantPage({super.key});

  @override
  State<ApplicantPage> createState() => _ApplicantPageState();
}

class _ApplicantPageState extends State<ApplicantPage> {
    final ValueNotifier<XFile?> applicantSignatureNotifier = ValueNotifier<XFile?>(null);
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applicant')),
      body: BlocConsumer<ApplicantBloc, ApplicantState>(
        builder: (context, state) {
          if (state is ApplicantSuccessState) {
            return Center(
              child: Text('Applicant Data: ${state.applicantResponseModel}'),
            );
          } 
          return const Center(child: Text('No data'));
        },
        listener: (context, state) => {},
      ),
    );
  }
}
