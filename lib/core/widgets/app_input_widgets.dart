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

Future<DateTime?> appDatePicker(
  BuildContext context, {
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? selectedDate,
}) async {
  firstDate ??= DateTime.now().subtract(const Duration(days: 360 * 90));
  lastDate ??= DateTime.now().add(const Duration(days: 365 * 20));

  DateTime initialDate = selectedDate ?? firstDate;
  if (initialDate.isAfter(lastDate)) {
    initialDate = lastDate;
  } else if (initialDate.isBefore(firstDate)) {
    initialDate = firstDate;
  } else {
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

  bool _isPdf(String? path) =>
      path?.toLowerCase().trim().endsWith('.pdf') ?? false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSizes.paddingInside,
        ), // Use AppSizes if you have them
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
                            Text(
                              'Add $title (pdf, png, jpg, jpeg)',
                              style: const TextStyle(fontSize: 12),
                            ),
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
                            icon: const Icon(
                              HugeIcons.strokeRoundedPencilEdit02,
                            ),
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
                                    builder:
                                        (_) => PdfViewPage(
                                          source: showPreview,
                                          isFromUrl: !isLocal,
                                        ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => PhotoViewPage(
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

class AppSheetInput<T> extends FormField<T> {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) getLabel;
  final String hint;
  final String label;
  final bool isSearchable;
  final double? height;

  AppSheetInput({
    super.key,
    required this.items,
    this.height,
    required this.selectedItem,
    super.initialValue,
    required this.getLabel,
    required void Function(T?) onChanged,
    this.isSearchable = false,
    required this.hint,
    required this.label,
    super.validator,
    bool autovalidateMode = false,
  }) : super(
         autovalidateMode:
             autovalidateMode
                 ? AutovalidateMode.onUserInteraction
                 : AutovalidateMode.disabled,
         builder: (FormFieldState<T> state) {
           return _AppSheetContent<T>(
             label: label,
             items: items,
             height: height,
             selectedItem: selectedItem,
             getLabel: getLabel,
             onChanged: (T? value) {
               state.didChange(value);
               onChanged(value);
             },
             hint: hint,
             isSearchable: isSearchable,
             errorText: state.errorText,
             state: state,
           );
         },
       );
}

class _AppSheetContent<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;
  final String hint;
  final String label;
  final bool isSearchable;
  final String? errorText;
  final double? height;
  final FormFieldState<T> state;

  const _AppSheetContent({
    required this.items,
    required this.height,
    required this.selectedItem,
    required this.getLabel,
    required this.onChanged,
    required this.hint,
    required this.label,
    required this.isSearchable,
    required this.errorText,
    required this.state,
  });

  @override
  State<_AppSheetContent<T>> createState() => _AppSheetContentState<T>();
}

class _AppSheetContentState<T> extends State<_AppSheetContent<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(covariant _AppSheetContent<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      setState(() {
        _filteredItems = widget.items;
      });
    }
  }

  void _showDropdown() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: widget.height,
              margin: const EdgeInsets.only(
                left: AppSizes.paddingBody,
                bottom: AppSizes.paddingBody,
                right: AppSizes.paddingBody,
              ),
              decoration: BoxDecoration(
                color: AppColors.onPrimary(context),
                borderRadius: BorderRadius.circular(AppSizes.radius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isSearchable) ...[
                    const SizedBox(height: AppSizes.paddingInside),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingBody,
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search...",
                          fillColor: AppColors.onInverseSurface(context),
                          prefixIcon: HugeIcon(
                            icon: HugeIcons.strokeRoundedSearch01,
                            color: AppColors.outline(context),
                            size: 20,
                          ),
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            _filteredItems =
                                widget.items
                                    .where(
                                      (item) => widget
                                          .getLabel(item)
                                          .toLowerCase()
                                          .contains(value.toLowerCase()),
                                    )
                                    .toList();
                          });
                        },
                      ),
                    ),
                    _buildListView(),
                  ] else
                    _buildListView(),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      _searchController.clear();
      setState(() {
        _filteredItems = widget.items;
      });
    });
  }

  Widget _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        final isSelected = widget.selectedItem == item;
        return ListTile(
          title: Text(
            widget.getLabel(item),
            style: TextStyle(
              color: isSelected ? AppColors.primary(context) : null,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          leading:
              isSelected
                  ? Icon(Icons.check, color: AppColors.primary(context))
                  : const SizedBox(width: 24),
          onTap: () {
            widget.onChanged(item);
            Navigator.pop(context);
            _searchController.clear();
            setState(() {
              _filteredItems = widget.items;
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = widget.selectedItem != null;

    return InkWell(
      onTap: _showDropdown,
      child: IgnorePointer(
        ignoring: true,
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(
            text: hasValue ? widget.getLabel(widget.selectedItem as T) : '',
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: const TextStyle(fontWeight: FontWeight.w400),
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: Colors.grey,
            ),
            errorText: widget.errorText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.seed),
            ),
          ),
        ),
      ),
    );
  }
}
