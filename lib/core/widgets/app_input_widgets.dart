import 'package:dac/core/constant/app_colors.dart';
import 'package:dac/core/widgets/app_network_image.dart';
import 'package:dac/core/widgets/app_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/app_sizes.dart';
import '../utilities/file_utils.dart';


class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    this.textInputAction,
    required this.labelText,
    required this.hintText,
    this.keyboardType,
    required this.controller,
    super.key,
    this.onChanged,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.onEditingComplete,
    this.autofocus,
    this.focusNode,
    this.readOnly,
  });

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String labelText;
  final String hintText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      validator: validator,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      onEditingComplete: onEditingComplete,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.seed),
        ),
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}

//for image picker
Future<XFile?> appImagePicker(BuildContext context) async {
  XFile? photo;
  final ImagePicker picker = ImagePicker();
  await showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder:
        (_) => Container(
          padding: const EdgeInsets.all(AppSizes.paddingInside),
          margin: const EdgeInsets.only(
            left: AppSizes.paddingBody,
            bottom: AppSizes.paddingBody,
            right: AppSizes.paddingBody,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radius),
          ),
          child: Wrap(
            spacing: 15,
            children: [
              ListTile(
                onTap: () async {
                  await picker.pickImage(source: ImageSource.gallery).then((
                    value,
                  ) {
                    if (value != null) {
                      photo = value;
                    }
                    if (context.mounted) {
                      Navigator.pop(context, photo);
                    }
                  });
                },
                leading: Icon(HugeIcons.strokeRoundedImage02),
                title: const Text(
                  "From Gallery",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(thickness: 0.5),
              ListTile(
                onTap: () async {
                  await picker.pickImage(source: ImageSource.camera).then((
                    value,
                  ) {
                    if (value != null) {
                      photo = value;
                    }
                    if (context.mounted) {
                      Navigator.pop(context, photo);
                    }
                  });
                },
                leading: Icon(HugeIcons.strokeRoundedCamera01),
                title: const Text(
                  "Take a Picture",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
  );

  return photo;
}



Future<DateTime?> appDatePicker(BuildContext context,
    {DateTime? firstDate, DateTime? lastDate, DateTime? selectedDate}) async {
  firstDate ??= DateTime.now().subtract(const Duration(days: 360 * 90));
  lastDate ??= DateTime.now().add(const Duration(days: 365 * 20));

  DateTime initialDate = selectedDate ?? firstDate;
  if (initialDate.isAfter(lastDate)) {
    initialDate = lastDate;
  } else if (initialDate.isBefore(firstDate)) {
    initialDate = firstDate;
  }else {
    initialDate = selectedDate ?? DateTime.now();
  }

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  return pickedDate ?? selectedDate;
}





class FilePickCard extends StatelessWidget {
  final String title;
  final String? existingFileUrl;
  final ValueNotifier<String?> fileNotifier;
  final IconData icon;

  const FilePickCard({
    super.key,
    required this.title,
    this.existingFileUrl,
    required this.fileNotifier,
    required this.icon,
  });

  bool _isPdf(String? path) => path?.toLowerCase().trim().endsWith('.pdf') ?? false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingInside), // Use AppSizes if you have them
        child: ValueListenableBuilder<String?>(
          valueListenable: fileNotifier,
          builder: (context, pickedFile, child) {
            final showPreview = pickedFile ?? existingFileUrl;
            final fileName = showPreview?.split('/').last;

            return Column(
              children: [
                // File display or uploader UI
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (showPreview != null)
                      Text(fileName ?? '')
                    else
                      InkWell(
                        onTap: () async {
                          final file = await FileUtils.pickSingleFile();
                          if (file != null) fileNotifier.value = file;
                        },
                        child: Column(
                          children: [
                            Icon(icon),
                            const SizedBox(height: 12),
                            Text('Add $title (pdf, png, jpg, jpeg)',
                                style: const TextStyle(
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ),
                  ],
                ),

                

                // Action buttons (edit, view, delete)
                if (showPreview != null)
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.paddingInside),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Edit
                          IconButton.outlined(
                            onPressed: () async {
                              final file = await FileUtils.pickSingleFile();
                              if (file != null) fileNotifier.value = file;
                            },
                            icon: const Icon(HugeIcons.strokeRoundedPencilEdit02),
                          ),
                          const SizedBox(width: 12),
                      
                          // View
                          IconButton.outlined(
                            onPressed: () {
                              final isPdf = _isPdf(showPreview);
                              final isLocal = pickedFile != null;
                      
                              if (isPdf) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PdfViewPage(
                                      source: showPreview,
                                      isFromUrl: !isLocal,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PhotoViewPage(
                                      imageUrl: existingFileUrl,
                                      imagePath: pickedFile,
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(HugeIcons.strokeRoundedZoomInArea),
                          ),
                          const SizedBox(width: 12),
                      
                          // Delete
                          IconButton.outlined(
                            onPressed: () {
                              fileNotifier.value = null;
                            },
                            icon: const Icon(
                              HugeIcons.strokeRoundedDelete02,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}


/*
FilePickCard(
  title: "License Copy",
  existingFileUrl: documentResponseModel?.licenseCopy,
  fileNotifier: licenseCopyNotifier,
  icon: HugeIcons.strokeRoundedLicense,
),
*/