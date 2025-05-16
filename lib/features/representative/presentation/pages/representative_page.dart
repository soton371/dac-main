import 'dart:io';

import 'package:dac/core/constant/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/app_urls.dart';
import '../../../../core/widgets/app_input_widgets.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/model/representative_response_model.dart';
import '../bloc/representative_bloc.dart';

class RepresentativePage extends StatefulWidget {
  const RepresentativePage({super.key});

  @override
  State<RepresentativePage> createState() => _RepresentativePageState();
}

class _RepresentativePageState extends State<RepresentativePage> {
  final ValueNotifier<XFile?> photoNotifier = ValueNotifier<XFile?>(null);
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController phoneCon = TextEditingController();
  final TextEditingController addressCon = TextEditingController();
  final TextEditingController designationCon = TextEditingController();
  final GlobalKey<FormState> _representativeFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    photoNotifier.dispose();
    nameCon.dispose();
    emailCon.dispose();
    phoneCon.dispose();
    addressCon.dispose();
    designationCon.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<RepresentativeBloc>().add(GetRepresentativeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Representative")),
      body: BlocConsumer<RepresentativeBloc, RepresentativeState>(
        listener: (context, state) {},
        builder: (context, state) {
          RepresentativeResponseModel? representative;
          if (state is RepresentativeSuccessState) {
            representative = state.representativeResponseModel;
            nameCon.text = representative.name ?? '';
            emailCon.text = representative.email ?? '';
            phoneCon.text = representative.phone ?? '';
            addressCon.text = representative.address ?? '';
            designationCon.text = representative.designation ?? '';
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
                      valueListenable: photoNotifier,
                      builder: (context, photoValue, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            photoValue == null
                                ? representative?.photo == null
                                    ? SizedBox.shrink()
                                    : AppNetworkImage(
                                      height: 100,
                                      width: 100,
                                      imageUrl:
                                          "${AppUrls.imageBaseUrl}/${representative?.photo}",
                                    )
                                : Image.file(File(photoValue.path)),

                            //for company logo pick
                            if (representative?.photo == null &&
                                photoValue == null)
                              InkWell(
                                onTap: () async {
                                  final companyLogo = await appImagePicker(
                                    context,
                                  );
                                  if (companyLogo != null) {
                                    photoNotifier.value = companyLogo;
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
                                    Text("Add Photo"),
                                  ],
                                ),
                              ),

                            if (representative?.photo != null ||
                                photoValue != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton.filledTonal(
                                    onPressed: () async {
                                      final companyLogo = await appImagePicker(
                                        context,
                                      );
                                      if (companyLogo != null) {
                                        photoNotifier.value = companyLogo;
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
                                                imageUrl: representative?.photo,
                                                imagePath: photoValue?.path,
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
                                      photoNotifier.value = null;
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
                key: _representativeFormKey,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingBody),
                    child: Column(
                      children: [
                        AppTextFormField(
                          controller: nameCon,
                          labelText: "Name",
                          hintText: "Enter Your Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          controller: emailCon,
                          labelText: "Email",
                          hintText: "Enter Your Email",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                            ).hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          controller: phoneCon,
                          labelText: "Phone",
                          hintText: "Enter Your Phone Number",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your phone number";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          controller: addressCon,
                          labelText: "Address",
                          hintText: "Enter Your Address",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSizes.paddingBody),
                        AppTextFormField(
                          controller: designationCon,
                          labelText: "Designation",
                          hintText: "Enter Your Designation",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your designation";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.height(context, 50)),
              FilledButton(onPressed: () {}, child: Text("Save")),
              const SizedBox(height: AppSizes.paddingBody),
            ],
          );
        },
      ),
    );
  }
}
