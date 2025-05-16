import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}