import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/shared/app_label_text.dart';
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
    this.labelIcon,
    this.endLabel,
    this.controller,
    this.validators,
    this.validator,
    this.bottomSpacing = true,
    this.initialValue
  });
  final String? initialValue;
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
  final IconData? labelIcon;
  final Widget? endLabel;
  final bool? bottomSpacing;
  final TextEditingController? controller;
  final List<Function>? validators;
  final dynamic validator;

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
          Row(
            children: [
              if (widget.labelIcon != null) ...[
                Icon(
                  widget.labelIcon,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
                HorizontalSpacing(4),
              ],
              AppLabelText(text: widget.label),
              if (widget.endLabel != null) ...[
                Spacer(),
                widget.endLabel!,
              ]
            ],
          ),
          VerticalSpacing(),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                //height: widget.maxLines! > 1 ? null : 45,
                child: TextFormField(
                  style: AppTextStyles.xxLarge(color: AppColors.primaryColor),
                  keyboardType: widget.textInputType,
                  obscureText: widget.hasPasswordEye! ? visible : false,
                  maxLines: widget.maxLines,
                  readOnly: widget.readOnlyField!,
                  onTap: widget.onTap,
                  validator: widget.validator,
                  initialValue: widget.initialValue,
                  // initial: widget.initialField
                  /* validator: (val) {
                    print(widget.validators);
                    if (widget.validators!.length > 0) {
                      var vadl = widget.validators![0];
                      return vadl(val);
                      /* String? foundValidator =
                          widget.validators!.first((Function callback) {
                        return callback(val);
                      });
 */
                      /* if (foundValidator!.isNotEmpty) {
                        return foundValidator;
                      } */
                    }
                    return null;
                  }, */
                  controller: widget.controller,
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
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.error, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: AppTextStyles.xSmall(color: AppColors.error),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.error, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
          if (widget.bottomSpacing!) VerticalSpacing(16),
        ],
      ),
    );
  }
}
