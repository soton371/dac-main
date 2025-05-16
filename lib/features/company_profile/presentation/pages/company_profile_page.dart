import 'dart:io';

import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/core/constant/app_urls.dart';
import 'package:dac/core/models/common_models.dart';
import 'package:dac/core/widgets/app_input_widgets.dart';
import 'package:dac/core/widgets/app_network_image.dart';
import 'package:dac/core/widgets/app_show_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utilities/app_date_time.dart';
import '../../data/models/company_request_model.dart';
import '../../data/models/company_response_model.dart';
import '../bloc/company_bloc.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key});

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  final TextEditingController companyNameCon = TextEditingController();
  final TextEditingController websiteCon = TextEditingController();
  final TextEditingController faxNumberCon = TextEditingController();
  final TextEditingController companyEmailCon = TextEditingController();
  final TextEditingController phoneNumberCon = TextEditingController();
  final TextEditingController addressOfCorrespondenceCon =
      TextEditingController();
  final TextEditingController yearOfEstablishmentCon = TextEditingController();
  final ValueNotifier<XFile?> companyLogoNotifier = ValueNotifier<XFile?>(null);
  final ValueNotifier<DateTime?> yearOfEstablishmentDateNotifier =
      ValueNotifier<DateTime?>(null);

  final GlobalKey<FormState> _companyFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    websiteCon.dispose();
    faxNumberCon.dispose();
    companyEmailCon.dispose();
    phoneNumberCon.dispose();
    addressOfCorrespondenceCon.dispose();
    yearOfEstablishmentCon.dispose();
    companyNameCon.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CompanyBloc>().add(CompanyEventGetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Profile')),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        builder: (context, state) {
          CompanyResponseModel? company;
          if (state is CompanySuccessState) {
            company = state.companyResponseModel;
            websiteCon.text = company.website ?? '';
            faxNumberCon.text = company.faxNumber ?? '';
            companyEmailCon.text = company.companyEmail ?? '';
            phoneNumberCon.text = company.phoneNumber ?? '';
            addressOfCorrespondenceCon.text =
                company.addressOfCorrespondence ?? '';
            yearOfEstablishmentCon.text =
                formatDateTime(dateTime: company.yearOfEstablishment) ?? '';
            companyNameCon.text = company.companyName ?? '';
            yearOfEstablishmentDateNotifier.value = company.yearOfEstablishment;
          }
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingInside),
                  child: SizedBox(
                    height: 100,
                    child: ValueListenableBuilder<XFile?>(
                      valueListenable: companyLogoNotifier,
                      builder: (context, valueCompanyLogo, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            valueCompanyLogo == null
                                ? company?.companyLogo == null
                                    ? SizedBox.shrink()
                                    : AppNetworkImage(
                                      height: 100,
                                      width: 100,
                                      imageUrl:
                                          "${AppUrls.imageBaseUrl}/${company?.companyLogo}",
                                    )
                                : Image.file(File(valueCompanyLogo.path)),

                            //for company logo pick
                            if (company?.companyLogo == null &&
                                valueCompanyLogo == null)
                              InkWell(
                                onTap: () async {
                                  final companyLogo = await appImagePicker(
                                    context,
                                  );
                                  if (companyLogo != null) {
                                    companyLogoNotifier.value = companyLogo;
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
                                    Text("Add Company Logo"),
                                  ],
                                ),
                              ),

                            if (company?.companyLogo != null ||
                                valueCompanyLogo != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton.filledTonal(
                                    onPressed: () async {
                                      final companyLogo = await appImagePicker(
                                        context,
                                      );
                                      if (companyLogo != null) {
                                        companyLogoNotifier.value = companyLogo;
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
                                                imageUrl: company?.companyLogo,
                                                imagePath:
                                                    valueCompanyLogo?.path,
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
                                      companyLogoNotifier.value = null;
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
                key: _companyFormKey,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.paddingBody),
                    child: Column(
                      children: [
                        AppTextFormField(
                          labelText: "Company Name",
                          hintText: "Enter Company Name",
                          controller: companyNameCon,
                          readOnly: true,
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          labelText: "Website",
                          hintText: "Enter Website",
                          controller: websiteCon,
                          readOnly: company?.isApplied,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Please enter website";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          labelText: "Fax Number",
                          hintText: "Enter Fax Number",
                          controller: faxNumberCon,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Please enter fax number";
                            }
                            return null;
                          },
                          readOnly: company?.isApplied,
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          labelText: "Company Email",
                          hintText: "Enter Company Email",
                          controller: companyEmailCon,
                          readOnly:
                              company?.companyEmail == null ? false : true,
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          labelText: "Phone Number",
                          hintText: "Enter Phone Number",
                          controller: phoneNumberCon,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Please enter phone number";
                            }
                            return null;
                          },
                          readOnly: company?.isApplied,
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          labelText: "Address of Correspondence",
                          hintText: "Enter Address of Correspondence",
                          controller: addressOfCorrespondenceCon,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Please enter address of correspondence";
                            }
                            return null;
                          },
                          readOnly: company?.isApplied,
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        ValueListenableBuilder(
                          valueListenable: yearOfEstablishmentDateNotifier,
                          builder: (
                            context,
                            yearOfEstablishmentDateValue,
                            child,
                          ) {
                            return InkWell(
                              onTap:
                                  company?.isApplied != true
                                      ? () async {
                                        final datePick = await appDatePicker(
                                          context,
                                          selectedDate:
                                              yearOfEstablishmentDateValue,
                                          lastDate: DateTime.now(),
                                        );
                                        if (datePick != null) {
                                          yearOfEstablishmentDateNotifier
                                              .value = datePick;
                                          yearOfEstablishmentCon.text =
                                              formatDateTime(
                                                dateTime: datePick,
                                              ) ??
                                              '';
                                        }
                                      }
                                      : null,
                              child: IgnorePointer(
                                ignoring: true,
                                child: AppTextFormField(
                                  labelText: "Year of Establishment",
                                  hintText: "Enter Year of Establishment",
                                  controller: yearOfEstablishmentCon,
                                  readOnly: true,
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return "Please enter year of establishment";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.height(context, 50)),

              if (company?.isApplied != true)
                FilledButton(
                  onPressed: () {
                    if (_companyFormKey.currentState!.validate()) {
                      final companyRequestModel = CompanyRequestModel(
                        website: websiteCon.text,
                        faxNumber: faxNumberCon.text,
                        phoneNumber: phoneNumberCon.text,
                        addressOfCorrespondence:
                            addressOfCorrespondenceCon.text,
                        yearOfEstablishment:
                            yearOfEstablishmentDateNotifier.value,
                      );

                      SendFileModel? companyLogoFile;

                      if (companyLogoNotifier.value != null) {
                        companyLogoFile = SendFileModel(
                          filePath: companyLogoNotifier.value!.path,
                          key: "company_logo",
                        );
                      }

                      if (company?.companyEmail == null) {
                        companyRequestModel.companyEmail = companyEmailCon.text;
                      }

                      context.read<CompanyBloc>().add(
                        CompanyEventUpdateData(
                          companyRequestModel: companyRequestModel,
                          file: companyLogoFile,
                        ),
                      );
                    }
                  },
                  child: const Text("Save"),
                ),
            ],
          );
        },
        listener: (context, state) {
          if (state is CompanyUpdateLoadingState) {
            appLoadingDialog(context);
          } else if (state is CompanyUpdateSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            //show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Company updated successfully")),
            );
          } else if (state is CompanyUpdateErrorState) {
            Navigator.pop(context);
            appShowInfo(context, title: 'Failed', content: state.errorMessage);
          }
        },
      ),
    );
  }
}
