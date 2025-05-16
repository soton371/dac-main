import 'package:dac/core/constant/app_sizes.dart';
import 'package:dac/features/home/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../company_profile/presentation/pages/company_profile_page.dart';
import '../../../document/presentation/page/document_page.dart';
import '../../../representative/presentation/pages/representative_page.dart';
import '../widgets/head_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeadWidget(title: "Soton Ahmed", subtitle: "soton.m360ict@gmail.com"),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(AppSizes.paddingBody),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ItemCard(
                        title: "Company Profile",
                        icon: HugeIcons.strokeRoundedBurjAlArab,
                        color: Colors.blue,
                        requiredFields: 6,
                        percent: 0.3,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompanyProfilePage(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingBody),
                    Expanded(
                      child: ItemCard(
                        title: "Documents",
                        icon: HugeIcons.strokeRoundedDocumentAttachment,
                        color: Colors.amber,
                        requiredFields: 9,
                        percent: 0,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DocumentPage(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.paddingBody),
                Row(
                  children: [
                    Expanded(
                      child: ItemCard(
                        title: "Representative",
                        icon: HugeIcons.strokeRoundedManager,
                        color: Colors.teal,
                        requiredFields: 6,
                        percent: 0,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RepresentativePage(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingBody),
                    Expanded(
                      child: ItemCard(
                        title: "Applicant",
                        icon: HugeIcons.strokeRoundedMale02,
                        color: Colors.lightBlueAccent,
                        requiredFields: 5,
                        percent: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppSizes.paddingBody,
              left: AppSizes.paddingBody,
              right: AppSizes.paddingBody,
            ),
            child: Text(
              "You can only submit after filling in all the required fields. Your progress so far is 20%.",
              style: TextStyle(color: Colors.grey, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingBody),
        child: FilledButton(onPressed: null, child: Text("Submit")),
      ),
    );
  }
}
