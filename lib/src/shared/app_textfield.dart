import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.hintText,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.hasPasswordEye = false,
    this.textInputType = TextInputType.text,
  });

  final String hintText;
  final String label;
  final bool? hasPasswordEye;
  final TextInputType? textInputType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.xxLarge(
              weight: FontWeight.w500,
              color: Color(0xFF3D3D3D),
            ),
          ),
          VerticalSpacing(),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: 45,
                child: TextFormField(
                  style: AppTextStyles.xxLarge(color: AppColors.primaryColor),
                  keyboardType: textInputType,
                  obscureText: hasPasswordEye! ? true : false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: hintText,
                    hintStyle: AppTextStyles.xMedium(color: Color(0xFF888888)),
                    prefixIcon: prefixIcon != null
                        ? Icon(
                            prefixIcon,
                            color: AppColors.primaryColor,
                            size: 22,
                          )
                        : null,
                    suffixIcon: suffixIcon != null
                        ? Icon(
                            suffixIcon,
                            color: AppColors.primaryColor,
                            size: 22,
                          )
                        : null,
                    contentPadding: EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: hasPasswordEye! ? 30 : 10,
                      bottom: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (hasPasswordEye!)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    'assets/images/icons/eye.png',
                    width: 18,
                  ),
                ),
            ],
          ),
          VerticalSpacing(16),
        ],
      ),
    );
  }
}
