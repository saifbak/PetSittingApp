import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.hintText,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.hasPasswordEye = false,
    this.textInputType = TextInputType.text,
    this.padding,
    this.maxLines = 1,
    this.readOnlyField = false,
    this.onTap,
  });

  final String hintText;
  final String label;
  final bool? hasPasswordEye;
  final TextInputType? textInputType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final EdgeInsets? padding;
  final int? maxLines;
  final bool? readOnlyField;
  final VoidCallback? onTap;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool visible = true;

  void togglePasswordVisibility() => setState(() => visible = !visible);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? AppBaseStyles.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTextStyles.xxLarge(
              weight: FontWeight.w500,
              color: AppColors.darkGray,
            ),
          ),
          VerticalSpacing(),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: widget.maxLines != null ? null : 45,
                child: TextFormField(
                  style: AppTextStyles.xxLarge(color: AppColors.primaryColor),
                  keyboardType: widget.textInputType,
                  obscureText: widget.hasPasswordEye! ? visible : false,
                  maxLines: widget.maxLines,
                  readOnly: widget.readOnlyField!,
                  onTap: widget.onTap,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: widget.hintText,
                    hintStyle: AppTextStyles.xMedium(color: Color(0xFF888888)),
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(
                            widget.prefixIcon,
                            color: AppColors.primaryColor,
                            size: 22,
                          )
                        : null,
                    suffixIcon: widget.suffixIcon != null
                        ? Icon(
                            widget.suffixIcon,
                            color: AppColors.primaryColor,
                            size: 22,
                          )
                        : null,
                    contentPadding: EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: widget.hasPasswordEye! ? 30 : 10,
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
              if (widget.hasPasswordEye!)
                GestureDetector(
                  onTap: togglePasswordVisibility,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      visible ? IconlyLight.show : IconlyLight.hide,
                      color: AppColors.primaryColor,
                      size: 22,
                    ),
                  ),
                )
            ],
          ),
          VerticalSpacing(16),
        ],
      ),
    );
  }
}
