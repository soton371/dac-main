import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/features/document/data/models/document_response_model.dart';
import 'package:dac/features/document/presentation/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constant/app_enum.dart';
import '../../../../core/utilities/app_date_time.dart';
import '../../../../core/widgets/app_input_widgets.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final ValueNotifier<String?> licenseCopyNotifier = ValueNotifier<String?>(
    null,
  );
  final TextEditingController licenseNumberController = TextEditingController();
  final ValueNotifier<String?> tradeLicenseCopyNotifier =
      ValueNotifier<String?>(null);
  final TextEditingController tradeLicenseNumberController =
      TextEditingController();
  final TextEditingController tradeLicenseExpiresInController =
      TextEditingController();
  final ValueNotifier<DateTime?> tradeLicenseExpiresInNotifier =
      ValueNotifier<DateTime?>(null);
  final ValueNotifier<String?> memorandumCopyNotifier = ValueNotifier<String?>(
    null,
  );
  final ValueNotifier<String?> articlesAssociationCopyNotifier =
      ValueNotifier<String?>(null);
  final TextEditingController tinNumberController = TextEditingController();
  final ValueNotifier<CompanyType?> companyTypeNotifier =
      ValueNotifier<CompanyType?>(null);

  @override
  void dispose() {
    licenseCopyNotifier.dispose();
    licenseNumberController.dispose();
    tradeLicenseCopyNotifier.dispose();
    tradeLicenseNumberController.dispose();
    tradeLicenseExpiresInController.dispose();
    tradeLicenseExpiresInNotifier.dispose();
    memorandumCopyNotifier.dispose();
    articlesAssociationCopyNotifier.dispose();
    tinNumberController.dispose();
    companyTypeNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // context.read<DocumentBloc>().add(DocumentGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document")),
      body: BlocConsumer<DocumentBloc, DocumentState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          DocumentResponseModel? documentResponseModel;
          if (state is DocumentSuccessState) {
            documentResponseModel = state.documentResponseModel;
          }
          return ListView(
            padding: EdgeInsets.all(AppSizes.paddingBody),
            children: [
              FilePickCard(
                title: "License Copy",
                existingFileUrl: documentResponseModel?.licenseCopy,
                fileNotifier: licenseCopyNotifier,
                icon: HugeIcons.strokeRoundedLicense,
              ),
              const SizedBox(height: AppSizes.paddingBody),
              AppTextFormField(
                controller: licenseNumberController,
                labelText: "License Number",
                hintText: "Enter License Number",
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return "Please enter license number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.paddingBody),
              FilePickCard(
                title: "Trade License Copy",
                existingFileUrl: documentResponseModel?.tradeLicenseCopy,
                fileNotifier: tradeLicenseCopyNotifier,
                icon: HugeIcons.strokeRoundedLicense,
              ),
              const SizedBox(height: AppSizes.paddingBody),
              AppTextFormField(
                controller: tradeLicenseNumberController,
                labelText: "Trade License Number",
                hintText: "Enter Trade License Number",
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return "Please enter trade license number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.paddingBody),
              ValueListenableBuilder(
                valueListenable: tradeLicenseExpiresInNotifier,
                builder: (context, tradeLicenseExpiresInValue, child) {
                  return InkWell(
                    onTap: () async {
                      final datePick = await appDatePicker(
                        context,
                        selectedDate: tradeLicenseExpiresInValue,
                      );
                      if (datePick != null) {
                        tradeLicenseExpiresInNotifier.value = datePick;
                        tradeLicenseExpiresInController.text =
                            formatDateTime(dateTime: datePick) ?? '';
                      }
                    },
                    child: IgnorePointer(
                      ignoring: true,
                      child: AppTextFormField(
                        labelText: "Trade License Expires In",
                        hintText: "Enter Trade License Expires In",
                        controller: tradeLicenseExpiresInController,
                        readOnly: true,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "Please enter trade license expires in";
                          }
                          return null;
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSizes.paddingBody),
              FilePickCard(
                title: "Memorandum Copy",
                existingFileUrl: documentResponseModel?.memorandumCopy,
                fileNotifier: memorandumCopyNotifier,
                icon: HugeIcons.strokeRoundedLicense,
              ),
              const SizedBox(height: AppSizes.paddingBody),
              FilePickCard(
                title: "Articles of Association Copy",
                existingFileUrl:
                    documentResponseModel?.articlesAssociationCopy,
                fileNotifier: articlesAssociationCopyNotifier,
                icon: HugeIcons.strokeRoundedLicense,
              ),
              const SizedBox(height: AppSizes.paddingBody),
              AppTextFormField(
                controller: tinNumberController,
                labelText: "TIN Number",
                hintText: "Enter TIN Number",
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return "Please enter TIN number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.paddingBody),
            ],
          );
        },
      ),
    );
  }
}
