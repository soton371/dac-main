import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../core/constant/app_sizes.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.title, required this.icon, required this.color, required this.requiredFields, required this.percent, this.onTap});
  final String title;
  final IconData icon;
  final Color color;
  final int requiredFields;
  final double percent;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withValues(alpha: 0.15),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingBody),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color,),
              const SizedBox(height: AppSizes.paddingInside),
              Text(title,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              LinearPercentIndicator(
                percent: percent,
                backgroundColor: Colors.white,
                progressColor: color,
                animation: true,
                animationDuration: 900,
                barRadius: Radius.circular(50),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 8),
              Text("$requiredFields fields required", style: TextStyle(fontSize: 10),)
            ],
          ),
        ),
      ),
    );
  }
}



