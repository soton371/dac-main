import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/features/document/data/models/document_response_model.dart';
import 'package:dac/features/document/presentation/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/app_enum.dart';
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
  final ValueNotifier<XFile?> tradeLicenseCopyNotifier = ValueNotifier<XFile?>(
    null,
  );
  final TextEditingController tradeLicenseNumberController =
      TextEditingController();
  final TextEditingController tradeLicenseExpiresInController =
      TextEditingController();
  final ValueNotifier<DateTime?> tradeLicenseExpiresInNotifier =
      ValueNotifier<DateTime?>(null);
  final ValueNotifier<XFile?> memorandumCopyNotifier = ValueNotifier<XFile?>(
    null,
  );
  final ValueNotifier<XFile?> articlesAssociationCopyNotifier =
      ValueNotifier<XFile?>(null);
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
            ],
          );
        },
      ),
    );
  }
}
