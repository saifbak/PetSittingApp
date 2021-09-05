import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.hintText,
    required this.label,
    this.prefixIconName,
    this.hasPasswordEye = false,
  });

  final String hintText;
  final String label;
  final String? prefixIconName;
  final bool? hasPasswordEye;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Airbnb Cereal',
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
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Airbnb Cereal',
                    color: AppColors.primaryColor,
                  ),
                  obscureText: hasPasswordEye! ? true : false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Airbnb Cereal',
                      color: Color(0xFF888888),
                    ),
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/images/icons/$prefixIconName.png',
                          ),
                        ),
                      ],
                    ),
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
