import 'dart:io';

import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/features/applicant/presentation/bloc/applicant_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/app_urls.dart';
import '../../../../core/widgets/app_input_widgets.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/model/applicant_response_model.dart';

class ApplicantPage extends StatefulWidget {
  const ApplicantPage({super.key});

  @override
  State<ApplicantPage> createState() => _ApplicantPageState();
}

class _ApplicantPageState extends State<ApplicantPage> {
  final ValueNotifier<XFile?> applicantSignatureNotifier =
      ValueNotifier<XFile?>(null);
  final TextEditingController applicantNameController = TextEditingController();
  final TextEditingController applicantDesignationController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController applicationDateController =
      TextEditingController();
  final GlobalKey<FormState> _applicantFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applicant')),
      body: BlocConsumer<ApplicantBloc, ApplicantState>(
        builder: (context, state) {
          ApplicantResponseModel? applicantResponseModel;
          if (state is ApplicantSuccessState) {
            applicantResponseModel = state.applicantResponseModel;
            applicantNameController.text =
                applicantResponseModel.applicantName ?? '';
            applicantDesignationController.text =
                applicantResponseModel.applicantDesignation ?? '';
            addressController.text = applicantResponseModel.address ?? '';
            applicationDateController.text =
                applicantResponseModel.applicationDate?.toString() ?? '';
          }
          return ListView(
            padding: EdgeInsets.all(AppSizes.paddingBody),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingInside),
                  child: SizedBox(
                    height: 100,
                    child: ValueListenableBuilder<XFile?>(
                      valueListenable: applicantSignatureNotifier,
                      builder: (context, valueApplicantSignature, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            valueApplicantSignature == null
                                ? applicantResponseModel?.applicantSignature ==
                                        null
                                    ? SizedBox.shrink()
                                    : AppNetworkImage(
                                      height: 100,
                                      width: 100,
                                      imageUrl:
                                          "${AppUrls.imageBaseUrl}/${applicantResponseModel?.applicantSignature}",
                                    )
                                : Image.file(
                                  File(valueApplicantSignature.path),
                                ),

                            //for company logo pick
                            if (applicantResponseModel?.applicantSignature ==
                                    null &&
                                valueApplicantSignature == null)
                              InkWell(
                                onTap: () async {
                                  final applicantSignature =
                                      await appImagePicker(context);
                                  if (applicantSignature != null) {
                                    applicantSignatureNotifier.value =
                                        valueApplicantSignature;
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      HugeIcons.strokeRoundedImageAdd02,
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      height: AppSizes.paddingInside,
                                    ),
                                    Text("Add Applicant Signature"),
                                  ],
                                ),
                              ),

                            if (applicantResponseModel?.applicantSignature !=
                                    null ||
                                valueApplicantSignature != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton.filledTonal(
                                    onPressed: () async {
                                      final companyLogo = await appImagePicker(
                                        context,
                                      );
                                      if (companyLogo != null) {
                                        applicantSignatureNotifier.value =
                                            companyLogo;
                                      }
                                    },
                                    icon: const Icon(
                                      HugeIcons.strokeRoundedPencilEdit02,
                                    ),
                                  ),
                                  const SizedBox(width: AppSizes.paddingBody),
                                  IconButton.filledTonal(
                                    onPressed: () {
                                      // Handle zoom in action
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => PhotoViewPage(
                                                imageUrl:
                                                    applicantResponseModel
                                                        ?.applicantSignature,
                                                imagePath:
                                                    valueApplicantSignature
                                                        ?.path,
                                              ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      HugeIcons.strokeRoundedZoomInArea,
                                    ),
                                  ),
                                  const SizedBox(width: AppSizes.paddingBody),
                                  IconButton.filledTonal(
                                    onPressed: () {
                                      // Handle save action
                                      applicantSignatureNotifier.value = null;
                                    },
                                    icon: const Icon(
                                      HugeIcons.strokeRoundedDelete02,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingBody),
              Form(
                key: _applicantFormKey,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingBody),
                    child: Column(
                      children: [
                        AppTextFormField(
                          controller: applicantNameController,
                          labelText: 'Applicant Name',
                          hintText: 'Enter Applicant Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          controller: applicantDesignationController,
                          labelText: 'Applicant Designation',
                          hintText: 'Enter Applicant Designation',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter designation';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          controller: addressController,
                          labelText: 'Address',
                          hintText: 'Enter Address',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                        ),
                        if (applicantResponseModel?.applicationDate != null)
                          Column(
                            children: [
                              const SizedBox(height: AppSizes.paddingBody),
                              AppTextFormField(
                                controller: applicationDateController,
                                labelText: 'Application Date',
                                hintText: 'Enter Application Date',
                                readOnly: true,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.height(context, 50)),
              FilledButton(onPressed: () {}, child: Text('Save')),
            ],
          );
        },
        listener: (context, state) => {},
      ),
    );
  }
}
